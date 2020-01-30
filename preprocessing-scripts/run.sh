#########################################Parameters#########################################
# Path to the folder that contains /txt/[text files for pretraining].
DATA_FOLDER=test_data_folder

if [ ! -d "$DATA_FOLDER" ]; then
  echo $DATA_FOLDER does not exist!
  exit
fi
if [ ! -d "$DATA_FOLDER/txt" ]; then
  echo $DATA_FOLDER does not contain a txt folder!
  exit
fi
# Path to the BERT github repo, default is inside this folder
export BERT_PATH=bert/
if [ ! -d "$BERT_PATH" ]; then
  echo $BERT_PATH does not exist, you can clone the repo from https://github.com/google-research/bert
  exit
fi

SHARD_DIR=$DATA_FOLDER/shards
DATA_DIR=$DATA_FOLDER/data
LOG_DIR=$DATA_FOLDER/logs
VOCAB=$DATA_FOLDER/vocab.txt
# size of the vocabulary to create
VOCAB_SIZE=10000
THREADS=12

mkdir -p ${SHARD_DIR}
mkdir -p ${DATA_DIR}
mkdir -p ${LOG_DIR}

# Google cloud bucket name
GC_BUCKET_NAME=name_of_google_cloud_bucket

#########################################SHARDING#########################################

echo ""
echo "BERT_BASE_DIR: ${DATA_FOLDER}"
echo "TEXT FILES: `ls ${DATA_FOLDER}/txt`"
echo ""
read -p "Continue (Y/N) " continue
if ! ( [ "${continue}" = "y" ] || [ "${continue}" = "Y" ] ); then exit 1; else echo "Continuing ... "; fi

python shuffle_shard.py --fnames $DATA_FOLDER/txt/* --outdir $SHARD_DIR

#########################################Vocabulary#########################################
# This writes the .model and .vocab files to the local directory.
python mkvocab.py --tokenized_dir ${SHARD_DIR} --out_vocab ${VOCAB} --vocab_size $VOCAB_SIZE

for f in $SHARD_DIR/*; do
   ((i=i%THREADS)); ((i++==0)) && wait
   python $BERT_PATH/create_pretraining_data.py \
       --input_file=${f} \
       --output_file=$DATA_DIR/"$(basename ${f})".tfrecord \
       --vocab_file=$VOCAB \
       --do_lower_case=False \
       --max_seq_length=128 \
       --do_whole_word_mask=True \
       --max_predictions_per_seq=20 \
       --masked_lm_prob=0.15 \
       --random_seed=12345 \
       --dupe_factor=5 2>&1 | tee $LOG_DIR/"$(basename ${f})".log &
done

gsutil -m cp -r $DATA_DIR/ gs://$GC_BUCKET_NAME/"$(basename ${DATA_FOLDER})"
