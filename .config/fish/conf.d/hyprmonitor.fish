function hdmi_display -a type -d "A utility that changes the display mode of HDMI-A-1";
    argparse 'h/help' 'v/verbose' -- $argv

    if set -q _flag_help
	_hdmi_display_help
	return
    end

    set -l hdmi (hyprctl monitors all | awk '/Monitor HDMI-A-1/{flag=1} flag; /availableModes/{flag=0}')

    if test "$type" != "mirror" -a "$type" != "extend"
	_hdmi_display_help
	return 1
    end


    # Checking if the monitor exists
    if not set -q hdmi[1]
	set_color red
        echo "No HDMI-A-1 monitor was found!" >&2
	set_color normal
	return 1
    end
    if set -q _flag_verbose
	set_color green
        echo "Monitor HDMI-A-1 was found!"
	set_color normal
    end

    # Setting the mirror
    if test "$type" = "mirror"
	hyprctl keyword monitor HDMI-A-1,1920x1080@60,0x0,1,mirror,eDP-1
    else
	hyprctl keyword monitor HDMI-A-1,1920x1080@60,-1920x0,1
    end
end

function _hdmi_display_help -d 'Help prompt for hdmi_display';
    echo """Nishant's custom function to configure his hdmi display

USAGE:
    hdmi_display <mirror|extend> [OPTIONS...]

OPTIONS:
    --help	-h	Display this help messsage
    --verbose	-v	Show the command that is executed"""
end
