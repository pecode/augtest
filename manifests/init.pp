# mkdir -p /opt/atlassian/confluence/atlassian-confluence-5.10/conf

class augtest {
 
  file { '/opt/atlassian/confluence/atlassian-confluence-5.10/conf/server.xml':
    ensure => file,
  }
  
  $webappdir = 'hello'
  $version = '5.10'
  $confluencedbuser = 'admin'
  $confluencedpassword = 'admin'
  $confluencedb = "jdbc:postgresql://localhost:5432/admin2"
  
  augeas { 'server.xml':
    lens => 'Xml.lns',
    incl => "${webappdir}/conf/server.xml",
    changes => [
      "ins Resource before /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Manager",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/name jdbc/confluence",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/auth Container",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/type javax.sql.DataSource",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/username ${confluencedbuser}",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/password ${confluencedpassword}",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/driverClassName org.postgresql.Driver",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/url jdbc:postgresql://localhost:5432/${confluencedb}",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/maxTotal 345",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/maxIdle 100",
      "set /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource/#attribute/validationQuery \"select 1\"",
    ],
    onlyif => "match /files/opt/atlassian/confluence/atlassian-confluence-${version}/conf/server.xml/Server/Service/Engine/Host/Context/Resource[1]/#attribute/name[.=\'jdbc/confluence\'] size == 0",
    #require => Class['confluence']
  }
}




