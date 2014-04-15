# manifests/site.pp
# this is cool http://johnleach.co.uk/words/771/puppet-dependencies-and-run-stages
#https://forge.puppetlabs.com/puppetlabs/apt 
# see ^ for info on 'apt-update' forces update prior to anypackage. this is good cause ..
class apt {
		include apt
    exec { "apt-update":
    command => "/usr/bin/apt-get update"
    }



# Ensure apt is setup before running apt-get update
    Apt::Key <| |> -> Exec["apt-update"]
    Apt::Source <| |> -> Exec["apt-update"]

# Ensure apt-get update has been run before installing any packages
    Exec["apt-update"] -> Package <| |>
}
# Install
    package {'awesome*':
    ensure => latest,
    }
    package {'conky-all':
    ensure => latest,
    }

    package {'xfonts-terminus*':
    ensure => latest,
    }
    package {'unagi':
    ensure => latest,
    }
    package {'touchegg':
    ensure => latest,
    }
    package {'rxvt-unicode':
    ensure => latest,
    }
    package {'xscreensaver*':
    ensure => latest,
    }
    package {'pommed':
    ensure => latest,
    }
    package {'suckless-tools':
    ensure => latest,
    }
    package {'xbattbar':
    ensure => latest,
    }

# group for shared root/user *(be sure to add yourself to the group in /etc/group with inline edit of "," at the end of the line followed by your username, with nospaces
#fixed group thing- it auto adds you now ... woo sed XD
    group { "uandgod":
    ensure => present,
    gid => 1337
    }


# conky stuff is cute... and pretty... like a happy little bunny thing... 
class conky {
		include conky
    }
class conky::useless {
	include conky::useless
	file { "~/.conkyrc":
		owner => "`whoami`",
		group => "root",
		mode => 755,
		source => "modules/conky/conkyrc",
		}


# attempts to add your logged in user to the uandgod group
class addgrouppersontogroup {
    exec { "addgrouppersontogroup":
    command => 'for Z in whoami ; do `sed -i "/uandgod/ s/$/root,$Z/" "/etc/group"`; done'
    } }

# terminal shinyness and things that look pretty...
class bash {
		include bash
    }
class bash::bashrc {
		include bash::bashrc
    file { "~/.bashrc":
        owner => 'root',
        group => 'uandgod',
        mode => 775,
        source => "modules/bash/.bashrc",
        }
    }
class bash::rxvt {
		include bash::rxvt
    file { "~/.Xdefaults":
        owner => 'root',
        group => 'uandgod',
        mode => 775,
        source => "modules/bash/.Xdefaults",
        }
    }

# all things awesome unless they're not then they're still awesome.
class awesome {
		include awesome

    }

class awesome::useless {
	include awesome::useless
	file { "/usr/share/awesome/lib/awful/layout/suit/spiral.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/spiral.lua",
		}
	file { "/usr/share/awesome/lib/awful/layout/suit/fair.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/fair.lua",
		}

	file { "/usr/share/awesome/lib/awful/layout/suit/floating.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/flaoting.lua",
		}	file { "/usr/share/awesome/lib/awful/layout/suit/init.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/init.lua",
		}
	file { "/usr/share/awesome/lib/awful/layout/suit/magnifier.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/magnifier.lua",
		}
	file { "/usr/share/awesome/lib/awful/layout/suit/max.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/max.lua",
		}	
	file { "/usr/share/awesome/lib/awful/layout/suit/tile.lua":
		owner => "root",
		group => "root",
		mode => 755,
		source => "modules/awesome/suit/tile.lua",
		}	
}

class awesome::awesomerc {
		include awesome::awesomerc
    file { "/etc/xdg/awesome/rc.lua":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/awesome/rc.lua",
        }
    }
class awesome::awesometheme0 {
		include awesome::awesometheme0
    file { "/usr/share/awesome/themes/default/theme.lua":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/awesome/theme.lua",
        }
    file { "/usr/share/awesome/themes/default/background.png":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/awesome/background.png",
        }
    file { "/usr/share/awesome/icons/awesome16.png":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/awesome/awesome16.png",
        }
     file { "/usr/share/awesome/icons/awesome32.png":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/awesome/awesome32.png",
        }
      file { "/usr/share/awesome/icons/awesome64.png":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/awesome/awesome64.png",
        }
    }

#xscreensaver goodies and configs
class xscreensaver {
		include xscreensaver
}

#pommed touch shit support for macbooks and like hardware
class pommed {
        include pommed
      file { "/etc/pommed.conf":
        owner => "root",
        group => "root",
        mode => 755,
        source => "modules/pommed/pommed.conf",
        }
}
class touchegg {
	   include touchegg
       file { "/usr/share/touchegg/touchegg.conf":
       owner => "root",
       group => "root",
       mode => 755,
       source => "modules/touchegg/touchegg.conf",
       }
   }

#hardware specific tasks .. working to make this viable on each of the following:  macbookpro,samsungativbook6,aceraspirev5
#notes working with `sudo dmidecode -s system-product-name`
#class product-of-dmidecode {
#    exec { "product-of-dmidecode":
#    command => "sudo /usr/sbin/dmidecode -s system-product-name"
#    }
#
# Ensure apt-get update has been run before installing any packages
#    Exec["product-of-dmidecode"] -> $product-of-dmidecode
#}
#acer renders: "Aspire V5-571P"
# # # will need evdev support for touch pad for 3finger = middle button touchegg may need to be installed on this / samsung models- for added screen support
#macbook renders: " "
#samsung renders: "870Z5E/880Z5E/680Z5E"
#actual command will have to be something like this:
#if {
#   $product-of-dmidecode == "Aspire V5-571P"
#   }
#elseif {
#   $product-of-dmidecode == "870Z5E/880Z5E/680Z5E"
#   }
#else {
#    include touchegg
#   }
#   warning('nothing special here these need extra touchscreen support for awesome multi finger gestures on screen')
