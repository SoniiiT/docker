<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
);
root@lxc-nextcloud:~/nextcloud/config# cat config.php
<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'apps_paths' =>
  array (
    0 =>
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 =>
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
  'upgrade.disable-web' => true,
  'instanceid' => 'ocbj2ol0pze6',
  'passwordsalt' => 'DYSe1/4uULS7xrGqGH+6pGrJhIo90v',
  'secret' => 'amLvPXF9thNu9gxD5+kgEy8XGXgCHiqcRG5SXqA/VGDUoH61',
  'trusted_domains' =>
  array (
    0 => 'docker-srv-02.home.soniiit.net:8080',
    1 => 'nextcloud.soniiit.net',
    2 => '192.168.178.68:80',
  ),
  'datadirectory' => '/var/www/html/data',
  'dbtype' => 'mysql',
  'version' => '31.0.4.1',
  'overwrite.cli.url' => 'http://docker-srv-02.home.soniiit.net:8080',
  'dbname' => 'nextcloud',
  'dbhost' => 'db',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'mysql.utf8mb4' => true,
  'dbuser' => 'nextcloud',
  'dbpassword' => 'aiousgd',
  'installed' => true,
  'overwriteprotocol' => 'https',
  'default_phone_region' => 'DE',
  'enable_previews' => true,
  'loglevel' => 2,
  'maintenance' => false,
);