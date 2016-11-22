#!/bin/bash

Cyan='\033[0;36m'
Default='\033[0;m'

projectName=""
httpsRepo=""
sshRepo=""
homePage=""
confirmed="n"

getProjectName() {
    echo -e "\n"
    read -p "Enter Project Name: " projectName

    if test -z "$projectName"; then
        getProjectName
    fi
}

getHTTPSRepo() {
    read -p "Enter HTTPS Repo URL: " httpsRepo

    if test -z "$httpsRepo"; then
        getHTTPSRepo
    fi
}

getSSHRepo() {
    read -p "Enter SSH Repo URL: " sshRepo

    if test -z "$sshRepo"; then
        getSSHRepo
    fi
}

getHomePage() {
    read -p "Enter Home Page URL: " homePage

    if test -z "$homePage"; then
        getHomePage
    fi
}

getInfomation() {
	echo -e "\n"
    getProjectName
    getHTTPSRepo
    getSSHRepo
    getHomePage

    echo -e "\n${Default}================================================"
    echo -e "  Project Name  :  ${Cyan}${ProjectName}${Default}"
    echo -e "  HTTPS Repo    :  ${Cyan}${httpsRepo}${Default}"
    echo -e "  SSH Repo      :  ${Cyan}${httpsRepo}${Default}"
    echo -e "  Home Page URL :  ${Cyan}${homePage}${Default}"
    echo -e "================================================\n"
}

while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getInfomation
    fi
    read -p "confirm? (y/n):" confirmed
done

mkdir -p "../${projectName}"

licenseFilePath="../${projectName}/FILE_LICENSE"
gitignoreFilePath="../${projectName}/.gitignore"
specFilePath="../${projectName}/${projectName}.podspec"
readmeFilePath="../${projectName}/readme.md"
uploadFilePath="../${projectName}/upload.sh"

cp ./templates/FILE_LICENSE "$licenseFilePath"
cp ./templates/gitignore    "$gitignoreFilePath"
cp ./templates/pod.podspec  "$specFilePath"
cp ./templates/readme.md    "$readmeFilePath"
cp ./templates/upload.sh    "$uploadFilePath"

sed -i "" "s:__PojectName__:${projectName}:g" "$gitignoreFilePath"
sed -i "" "s:__PojectName__:${projectName}:g" "$readmeFilePath"
sed -i "" "s:__PojectName__:${projectName}:g" "$uploadFilePath"

sed -i "" "s:__PojectName__:${projectName}:g" "$specFilePath"
sed -i "" "s:__HomePage__:${homePage}:g"      "$specFilePath"
sed -i "" "s:__HTTPSRepo__:${httpsRepo}:g"    "$specFilePath"

cd ./$projectName
git remote add origin $sshRepo
git rm -rf --cached $projectName.xcodeproj/xcuserdata/
git rm -rf --cached $projectName.xcworkspace/
git rm -rf --cached ./Pods/
git rm -rf --cached __ProjectName__.xcodeproj/project.xcworkspace/xcuserdata/
git rm --cached Podfile.lock
git rm --cached .DS_Store
