#!/bin/bash
set -e   # stop if any command fails

VERSION=$(date +%Y%m%d%H%M)   # timestamp as tag


show_usage()
{
    echo "Vortex BlackBox Test Driver v1.0"
    echo "Usage: $0 [[--image=app1 or app2 or app3 ][--username= user personal docker hup ]  [--appsdir=directory of build] [--release= helm release name] [--namespace = env1]]"
}

show_help()
{
    show_usage
    echo "  where"
    echo "--image: the app image name e.g app1 , app2 , app3"
    echo "--usernam: Docker hub and the name tag of image"
    echo "--appsdir: Apps directory that have each app Docker folde e.g ./app1/Dockerfile"
    echo "--release: Release name of helm chart "  
    echo "--namespace: namespace of app e.g env1 , env2 "
    #echo "--chartpath: path of helm chart "


} 
DEFAULTS() {
    username=omargabr0
    appsdir=/usr/new/task2/build-dir
    ENV=default


}

parse_args() {
    DEFAULTS
for i in "$@"; do
    case $i in 
        
        --username=*) DOCKER_USER=${i#*=} ;;
        --appsdir=*) DOCKER_DIR=${i#*=} ;;
        --release=*)  RELEASE=${i#*=} ;;
        --image=*) $IMAGE_NAME=${i#*=} ;;
        --namespace=*) $ENV=${i#*=} ;;
        #--chartpath=*) CHPATH=${i#*=} ;;
        --help)     show_help; exit 0 ;;
        *)          show_usage; exit 1 ;;
    esac

done
}
#login check 
login(){
if docker info 2>/dev/null | grep -q "Username: $DOCKER_USER"; then
    echo " Already logged in to Docker Hub"
else
    echo " Not logged in. Login to docker hub first"
    exit 0
fi
}
#  Build image
build(){
echo ">>> Building Docker image..."
docker build -t $DOCKER_USER/$IMAGE_NAME:$VERSION ./$IMAGE_NAME
# Tag image
}

#  Push image
push(){
echo ">>> Pushing Docker image to Docker Hub..."
docker push $DOCKER_USER/$IMAGE_NAME:$VERSION
}

#  Update Kubernetes deployment
update() {
    if [ "$IMAGE" = "app2" ]; then
        helm upgrade $RELEASE ../$IMAGE_NAME/$IMAGE_NAME -f values-${ENV}.yaml --set image.tag=$VERSION
    else
        echo ">>> Updating Kubernetes deployment Using Helm charts..."
        helm upgrade $RELEASE ../$IMAGE_NAME/$IMAGE_NAME --set image.tag=$VERSION
    fi
}

main (){
    
    parse_args "$@"
    login
    build
    push
    update



echo ">>> Deployment successful with image $IMAGE_NAME:$VERSION"
echo ">>> Helm shart $RELEASE updated with image $IMAGE_NAME:$VERSION"
}

main "$@"