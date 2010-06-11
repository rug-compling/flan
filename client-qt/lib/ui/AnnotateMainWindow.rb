require 'Qt4'

require 'flan_client'
require 'ui/ConnectDialog'
require 'ui/ui_AnnotateMainWindow'

class JudgmentItem < Qt::StandardItem
  attr_accessor :logicalFormId, :realizationId, :judgmentId
end

class LogicalFormItem < Qt::StandardItem
  attr_accessor :id, :key, :judgmentCount
end

class AnnotateMainWindow < Qt::MainWindow  
  def initialize(parent = nil)
    # Set up user interface
    super
    @base = Ui::AnnotateMainWindow.new
    @base.setupUi self
    
    Qt::Object.connect(@base.addSuggestPushButton, SIGNAL('clicked()'), self,
      SLOT('addRealization()'))
    Qt::Object.connect(@base.suggestLineEdit, SIGNAL('returnPressed()'), self,
      SLOT('addRealization()'))
      
    
    @connectDialog = ConnectDialog.new(self)
    Qt::Object.connect(@connectDialog, SIGNAL('rejected()'), self, SLOT('close()'))
    Qt::Object.connect(@connectDialog, SIGNAL('accepted()'), self, SLOT('showLfs()'))
    
    Qt::Object.connect(@base.zoomInAction, SIGNAL('triggered(bool)'), self, SLOT('zoomIn(bool)'))
    Qt::Object.connect(@base.zoomOutAction, SIGNAL('triggered(bool)'), self, SLOT('zoomOut(bool)'))
    
    readSettings
    
    @connectDialog.show
  end
    
  def close
    writeSettings
    super
  end

  private
  
  slots 'addRealization()', 'close()', 'lfSelected(const QModelIndex &, const QModelIndex &)',
    'showLfs()', 'judgmentChanged(QStandardItem *)', 'zoomIn(bool)', 'zoomOut(bool)'
    
  ZOOM_OUT_FACTOR = 0.8
  ZOOM_IN_FACTOR = 1.0 / ZOOM_OUT_FACTOR

  def addRealization
    realization = @base.suggestLineEdit.text
    
    if !realization.empty?
      idx = @base.lfListView.currentIndex
      item = @base.lfListView.model.itemFromIndex(idx)
      @client.createRealization(item.id, realization)

      @base.suggestLineEdit.clear
      showRealizations(item.id)
    end
  end
  
  def judgmentChanged(item)
    if (item.checkState == Qt::Checked)
      judgmentId = @client.createJudgment(item.logicalFormId, item.realizationId)
      item.judgmentId = judgmentId
    else
      if (!item.judgmentId.nil?)
        @client.deleteJudgment(item.judgmentId)
        item.judgmentId = nil
      end
    end
  end
  
  def readSettings()
    settings = Qt::Settings.new('RUG', 'Fluency Annotation')
    
    # Window geometry
    size = settings.value('size', Qt::Variant.new(Qt::Size.new(800, 500))).toSize
    resize(size)
    pos = settings.value('pos', Qt::Variant.new(Qt::Point.new(200, 200))).toPoint
    move(pos)
    
    # Splitter states
    state = settings.value('indexDetailSplitter').toByteArray
    @base.indexDetailSplitter.restoreState(state)
    state = settings.value('structRelSplitter').toByteArray
    @base.structRelSplitter.restoreState(state)
    
    # Login
    server = settings.value('server').toString
    @connectDialog.server = server
    email = settings.value('email').toString
    @connectDialog.email = email
  end
  
  def showLfs
    url = @connectDialog.server
    email = @connectDialog.email
    password = @connectDialog.password

    # Make database connection, and retrieve logical forms    
    @client = FlanClient::FlanClient.new(url, email, password)
    begin
      lfs = @client.lf_keys
    rescue => e
      Qt::MessageBox.critical(self, "Connection error",
        "Could not connect to #{@connectDialog.server}:\n#{e}")
      @connectDialog.show
      return
    end
    
    model = Qt::StandardItemModel.new(@base.lfListView)
    
    lfs.each { |lf|
      item = LogicalFormItem.new(lf['key'])
      item.setEditable(false)
      item.id = lf['id']
      item.key = lf['key']
      item.judgmentCount = lf['judgment_count'].to_i
      
      if item.judgmentCount == 1
        item.setBackground(Qt::Brush.new(Qt::Color.fromRgb(230, 255, 230)))
      elsif item.judgmentCount > 1
        item.setBackground(Qt::Brush.new(Qt::Color.fromRgb(200, 255, 200)))
      end
            
      model.appendRow(item)
    }
    
    selectionModel = Qt::ItemSelectionModel.new(model)
    Qt::Object.connect(selectionModel,
      SIGNAL('currentChanged(const QModelIndex &, QModelIndex const &)'),
      self, SLOT('lfSelected(const QModelIndex &, QModelIndex const &)'))
    
    @base.lfListView.setModel(model)
    @base.lfListView.setSelectionModel(selectionModel)
  end
  
  def lfSelected(current, prev)
    item = @base.lfListView.model.itemFromIndex(current)
    begin
      showStructure(item.id)
      showRealizations(item.id)
    rescue => e
      Qt::MessageBox.critical(self, "Connection error",
        "Could not retrieve data from #{@connectDialog.server}:\n#{e}")
    end
  end
  
  def showStructure(lfId)
    structure = @client.structure(lfId)

    svgRenderer = Qt::SvgRenderer.new(Qt::ByteArray.new(structure))
    
    scene = Qt::GraphicsScene.new(@base.structureGraphicsView)

    svgGraphicsItem = Qt::GraphicsSvgItem.new()
    svgGraphicsItem.setSharedRenderer(svgRenderer)
    scene.addItem(svgGraphicsItem)
    
    @base.structureGraphicsView.setScene(scene)
    @base.structureGraphicsView.fitInView(svgGraphicsItem, Qt::KeepAspectRatio)
  end

  def showRealizations(lfId)
    model = Qt::StandardItemModel.new(@base.realizationsListView)
    
    realizations = @client.realizations(lfId)
    
    realizations.each { |rel|
      item = JudgmentItem.new(rel[:sentence])
      item.setEditable(false)
      item.logicalFormId = rel[:logicalFormId]
      item.realizationId = rel[:realizationId]
      
      if rel[:most_fluent]
        item.judgmentId = rel[:judgmentId]
      end

      check = rel[:most_fluent] == '1' ? Qt::Checked : Qt::Unchecked
      item.setCheckState(check)
      item.setCheckable(true)
      model.appendRow(item)
    }
    
    Qt::Object.connect(model, SIGNAL('itemChanged(QStandardItem *)'),
      self, SLOT('judgmentChanged(QStandardItem *)'))
    
    @base.realizationsListView.setModel(model)
  end
  
  def writeSettings
    settings = Qt::Settings.new('RUG', 'Fluency Annotation')
    
    # Window geometry
    settings.setValue('pos', Qt::Variant.new(pos))
    settings.setValue('size', Qt::Variant.new(size))
    
    # Splitter states
    settings.setValue('indexDetailSplitter',
      Qt::Variant.new(@base.indexDetailSplitter.saveState))
    settings.setValue('structRelSplitter',
      Qt::Variant.new(@base.structRelSplitter.saveState))
    
    # Login
    settings.setValue('server', Qt::Variant.new(@connectDialog.server))
    settings.setValue('email', Qt::Variant.new(@connectDialog.email))
  end
  
  def zoomIn(checked)
    @base.structureGraphicsView.scale(ZOOM_IN_FACTOR, ZOOM_IN_FACTOR)
  end
  
  def zoomOut(checked)
    @base.structureGraphicsView.scale(ZOOM_OUT_FACTOR, ZOOM_OUT_FACTOR)
  end
end
