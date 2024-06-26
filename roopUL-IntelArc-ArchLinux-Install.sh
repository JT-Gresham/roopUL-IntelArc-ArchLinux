#!/usr/bin/env bash

echo "########## roopUL for Intel Arc GPUs on Arch Linux ##########"
echo "##################### fork by JT Gresham #####################"
echo ""
echo "*     This installer requires that you have up-to-date drivers for your Intel Arc GPU."
echo "*     You also need to have Python 3.10 installed since this installer creates your"
echo "           python virtual environment with it."
echo "*     This installer will check/install a couple of packages via PACMAN. These are installed"
echo "          from the offical Arch repositories so you will be asked to authorize the install with"
echo "          your password."
echo "*     This installer will create a customized start script by using the information you enter."
echo ""
echo "Press enter to continue the installation..."
read go
sudo pacman -S intel-compute-runtime intel-graphics-compiler ocl-icd opencl-headers --needed
echo ""
echo "What is the FULL PATH of directory where you want to install \"roopUL-IntelArc-ArchLinux\"?"
echo "---Exclude the trailing \"/\"---"
read pdirectory
echo ""
echo "Your installation will be installed in $pdirectory/roopUL-IntelArc-ArchLinux"
echo ""
echo "Changing directory -> $pdirectory"
cd $pdirectory
echo ""
git clone https://github.com/JT-Gresham/roopUL-IntelArc-ArchLinux.git
echo ""
echo "Changing directory ->$pdirectory/roopUL-IntelArc-ArchLinux"
cd $pdirectory/roopUL-IntelArc-ArchLinux
echo ""
echo "Creating python 3.10 environment (roopUL-IntelArc-ArchLinux_env)"
/usr/bin/python3.10 -m venv roopUL-IntelArc-ArchLinux_env
echo ""
echo "Activating environment -> roopUL-IntelArc-ArchLinux_env"
source roopUL-IntelArc-ArchLinux_env/bin/activate
echo ""
echo "Installing wheel package..."
pip install wheel
echo ""
echo "Installing packages from requirements.txt..."
pip install -r requirements.txt
echo ""
echo "Creating the base start file (roopUL-Start.sh)"
touch $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "#!/usr/bin/env bash" > $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "source $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-IntelArc-ArchLinux_env/bin/activate" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "export LD_LIBRARY_PATH=$pdirectory/roopUL-IntelArc-ArchLinux/roopUL-IntelArc-ArchLinux_env/lib" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "python $pdirectory/roopUL-IntelArc-ArchLinux/run.py --execution-provider openvino" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "#This file can be copied and the final python command can be modified with any roopUL arguments (like --preset realistic). Just add arguments after entry_with_update.py" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "" >> $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "Setting the new start file to be executable. (Authorization Required)"
sudo chmod +x $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh
echo "Installation complete. Start with command: $pdirectory/roopUL-IntelArc-ArchLinux/roopUL-Start.sh"
