require 'Qt4'

require 'ui_ConnectDialog'

class ConnectDialog < Qt::Dialog
  def initialize(parent = nil)
    super
    @base = Ui::ConnectDialog.new
    @base.setupUi self    
  end
  
  def server
    @base.serverLineEdit.text
  end
  
  def server=(server)
    @base.serverLineEdit.setText(server)
  end
  
  def email
    @base.emailLineEdit.text
  end
  
  def email=(email)
    @base.emailLineEdit.setText(email)
  end
  
  def password
    @base.passwordLineEdit.text
  end
end