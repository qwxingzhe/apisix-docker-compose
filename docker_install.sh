#!/bin/bash
DISTRO=$(awk -F= '/^DISTRIB_ID/{print $2}' "/etc/lsb-release")
INSTALLED=0

install_docker(){
    local DISTRO=$1
    local INSTALLED=$2
    local blue='\033[1;34m'
    local white='\033[0;37m'
    case $DISTRO in 
        Ubuntu | Debian ) 
            sudo apt-get -y remove docker docker-engine docker.io containerd runc
            sudo snap remove docker
            sudo apt-get -y update
            sudo apt-get -y install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
            echo \
            "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get -y update
            sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose
            sudo groupadd docker
            sudo usermod -aG docker $USER
            INSTALLED=1
        
        ;;
        CentOS) 
            sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
            sudo yum install -y yum-utils
            sudo yum-config-manager \
                --add-repo \
                https://download.docker.com/linux/centos/docker-ce.repo
            sudo yum install -y docker-ce docker-ce-cli containerd.io
            sudo systemctl start docker
            sudo groupadd docker
            sudo usermod -aG docker $USER
            INSTALLED=1
        ;;
        RedHat | RHEL) 
            sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc
            sudo yum install -y yum-utils
            sudo yum-config-manager \
                --add-repo \
                https://download.docker.com/linux/rhel/docker-ce.repo
            sudo yum install -y docker-ce docker-ce-cli containerd.io
            sudo systemctl start docker
            sudo groupadd docker
            sudo usermod -aG docker $USER
            INSTALLED=1
        ;;
        *) 
            echo -e "No Scripts are found for your system to install docker. \nHead to this link to install docker on your linux distribution manually \n https://docs.docker.com/engine/install/"
        ;;
    esac

    if [ $INSTALLED == 1 ]; then
        echo -e "\n__________________________________________________\nDocker is now installed on your $DISTRIBUTION system."
        echo -e "${blue}==========================================================================\nReboot or Logout Login your system to get your group membership evaluated or run docker command with \"sudo\"\n==========================================================================${white}"
    fi


}

while true; do    
    read -n 1 -p "Do you want to install Docker [y for Yes  ;  n for No  ;  q  for Quit] " yn
    echo ""
    case $yn in
        [Yy]* ) echo "Installing Docker" && install_docker $DISTRO $INSTALLED ; break;;
        [Nn]* ) break ;;
        [Qq]* ) exit 0;;
        * ) echo "Please provide a yes or no answer."
    esac
done
