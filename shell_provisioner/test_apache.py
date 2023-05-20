import testinfra

def test_apache_is_installed(host):
    assert host.package("httpd").is_installed

def test_apache_is_running(host):
    assert host.service("httpd").is_running
    assert host.service("httpd").is_enabled

def test_apache_virtual_host(host):
    virtual_host = """
    <VirtualHost *:80>
        ServerName helloworld.myexample.com
        DocumentRoot /var/www/html
        ErrorLog /var/log/httpd/error.log
        CustomLog /var/log/httpd/access.log combined
        <Directory /var/www/html>
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>
    """
    assert host.file("/etc/httpd/conf.d/helloworld.conf").exists
    assert host.file("/etc/httpd/conf.d/helloworld.conf").contains(virtual_host)

def test_apache_index_html(host):
    assert host.file("/var/www/helloworld/index.html").exists
    assert host.file("/var/www/helloworld/index.html").contains("<title>PackerDemo</title>")
    assert host.file("/var/www/helloworld/index.html").contains("<h1>Hello World!</h1>")
