for zone in {\
asia-east1-a,\
asia-east1-b,\
asia-east1-c,\
asia-northeast1-a,\
asia-northeast1-c,\
asia-northeast3-b,\
asia-northeast3-c,\
asia-south1-a,\
asia-south1-b,\
asia-southeast1-a,\
asia-southeast1-b,\
asia-southeast1-c,\
asia-southeast2-a,\
asia-southeast2-b,\
asia-southeast2-c,\
australia-southeast1-b,\
australia-southeast1-c,\
europe-west1-b,\
europe-west1-c,\
europe-west1-d,\
europe-west2-a,\
europe-west2-b,\
europe-west3-b,\
europe-west4-a,\
europe-west4-b,\
europe-west4-c,\
northamerica-northeast1-a,\
northamerica-northeast1-b,\
northamerica-northeast1-c,\
southamerica-east1-c,\
us-central1-a,\
us-central1-b,\
us-central1-c,\
us-central1-f,\
us-east1-b,\
us-east1-c,\
us-east1-d,\
us-east4-a,\
us-east4-b,\
us-east4-c,\
us-west1-a,\
us-west1-b,\
us-west2-b,\
us-west2-c,\
us-west4-a,\
us-west4-b\
};
do 
    echo $zone;
    gcloud compute instances create gpu-machine-$zone --project=meme-db-prod --zone=$zone --machine-type=n1-standard-4 --network-interface=network-tier=PREMIUM,subnet=default --maintenance-policy=TERMINATE --provisioning-model=STANDARD --service-account=316156922495-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --accelerator=count=1,type=nvidia-tesla-a100 --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/ml-images/global/images/c2-deeplearning-pytorch-1-12-cu113-v20221107-debian-10,mode=rw,size=100,type=projects/meme-db-prod/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
    if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
done