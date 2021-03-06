sudo apt-get update
sudo apt-get install git
sudo apt-get install zip
sudo apt-get install tmux
sudo apt-get install python-pip
pip install numpy
pip install tensorflow
pip install --upgrade google-api-python-client
pip install --upgrade oauth2client
git clone https://github.com/google-research/bert.git

GC_BUCKET_NAME=name_of_google_cloud_bucket
echo "tpu=\${1}
B=gs://${GC_BUCKET_NAME}/test_data_folder

python ./bert/run_pretraining.py \\
       --input_file=$B/data/*.tfrecord \\
       --output_dir=$B/pretraining_output \\
       --do_train=True \\
       --do_eval=True \\
       --bert_config_file=$B/bert_config.json \\
       --train_batch_size=32 \\
       --max_seq_length=128 \\
       --use_tpu=True \\
       --tpu_name=\${tpu} \\
       --num_tpu_cores=8 \\
       --max_predictions_per_seq=20 \\
       --num_train_steps=2000000 \\
       --num_warmup_steps=10000 \\
       --save_checkpoints_steps=25000 \\
       --learning_rate=1e-4 2>&1 | tee log-\${tpu}.txt
" >> run.sh