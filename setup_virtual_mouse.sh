#!/bin/bash

echo "Starting Virtual Mouse Setup for Fluxbox & IceWM..."

# 1. Install xdotool
sudo apt update && sudo apt install -y xdotool

# 2. Create the Toggle Script
cat << 'EOF' > ~/mouse_toggle.sh
#!/bin/bash
if [ -f /tmp/mouse_is_down ]; then
    xdotool mouseup 1
    rm /tmp/mouse_is_down
else
    xdotool mousedown 1
    touch /tmp/mouse_is_down
fi
EOF
chmod +x ~/mouse_toggle.sh

# 3. Add Fluxbox Keybindings (if directory exists)
if [ -d ~/.fluxbox ]; then
    echo "Configuring Fluxbox..."
    cat << 'EOF' >> ~/.fluxbox/keys

# --- VIRTUAL MOUSE SECTION ---
Mod4 Left :Exec xdotool mousemove_relative -- -100 0
Mod4 Right :Exec xdotool mousemove_relative 100 0
Mod4 Up :Exec xdotool mousemove_relative -- 0 -100
Mod4 Down :Exec xdotool mousemove_relative 0 -100
Control Mod4 Left :Exec xdotool mousemove_relative -- -5 0
Control Mod4 Right :Exec xdotool mousemove_relative 5 0
Control Mod4 Up :Exec xdotool mousemove_relative -- 0 -5
Control Mod4 Down :Exec xdotool mousemove_relative 0 5
Mod4 Return :Exec xdotool click 1
Mod4 BackSpace :Exec xdotool click 3
Mod4 space :Exec xdotool click 2
Mod4 Prior :Exec xdotool click 4
Mod4 Next :Exec xdotool click 5
Mod4 t :Exec ~/mouse_toggle.sh
Mod4 c :Exec xdotool mousemove 50% 50%
EOF
fi

# 4. Add IceWM Keybindings (if directory exists)
if [ -d ~/.icewm ]; then
    echo "Configuring IceWM..."
    cat << 'EOF' >> ~/.icewm/keys

# --- VIRTUAL MOUSE SECTION ---
key "Alt+Left" xdotool mousemove_relative -- -100 0
key "Alt+Right" xdotool mousemove_relative 100 0
key "Alt+Up" xdotool mousemove_relative -- 0 -100
key "Alt+Down" xdotool mousemove_relative 0 100
key "Shift+Alt+Left" xdotool mousemove_relative -- -5 0
key "Shift+Alt+Right" xdotool mousemove_relative 5 0
key "Shift+Alt+Up" xdotool mousemove_relative -- 0 -5
key "Shift+Alt+Down" xdotool mousemove_relative 0 5
key "Alt+Return" xdotool click 1
key "Alt+BackSpace" xdotool click 3
key "Alt+space" xdotool click 2
key "Alt+Prior" xdotool click 4
key "Alt+Next" xdotool click 5
key "Alt+t" ~/mouse_toggle.sh
key "Alt+c" xdotool mousemove 50% 50%
EOF
fi

# 5. Add Bash Aliases
echo "Adding Bash Aliases..."
cat << 'EOF' >> ~/.bashrc
# Mouse Aliases
alias mcenter='xdotool mousemove 50% 50%'
alias mclick='xdotool click 1'
alias mrclick='xdotool click 3'
alias mhide='xdotool mousemove 9999 9999'
EOF

echo "Setup Complete! Please restart your Window Manager or reboot."
