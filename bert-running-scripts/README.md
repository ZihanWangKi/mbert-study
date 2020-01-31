## Pre-training BERT
#### Preparation
- Google Cloud Bucket Storage
- Google Cloud Instance
- Google Cloud Tpu

When creating a google cloud instance, make sure full api access is turned on.  
Correctly set GC_BUCKET_NAME in ``init-gcloud-server.sh`` to your cloud storage bucket name.  
In a google cloud instance, run ``init-gcloud-server.sh`` and ``run.sh`` will be created.   
Executing ``run.sh`` and passing it a tpu name initiates bert training.  