class wget {


define download (
                  $app,
                  $url,
                  $destination
                )

{
notify{"Attempting to download ${app} from ${url} to ${destination}":}

exec { 
      "$app" :
          command => "wget $url -P $destination",
          path => "/usr/local/bin:/bin:/usr/bin",
          creates => ["${destination}/${app}.tar.gz","${destination}/${app}.tgz"];
    
      "$app-untar" :
         command=>"tar xvfz ${destination}/${app}.t* -C ${destination}/",
         path => "/usr/local/bin:/bin:/usr/bin",
         creates => "${destination}/${app}/",
         require => [Exec["$app"]];
}
}
}
class run ( $command ,  $path ) {
    exec { "runit" :
      environment => [JAVA_HOME=/usr/lib/jvm/java-7-oracle/],
      command => "${path}/${command}",
      returns => [0,1]
    } 
}
class setevn($envvar,$value) {
    file { "/etc/environment":
        content => inline_template("${envvar}=${value}")
    }
}
