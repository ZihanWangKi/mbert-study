## Preprocessing-scripts
#### Preparation
- [Wikipedia](https://dumps.wikimedia.org/) text data if training from scratch. We also release our training data on English(en), Spanish(es), Hindi(hi), and Russian(ru) [here](../data.json).

We first provide a basic usage of our scripts.  
``init.sh`` will clone the official BERT repo, and create a ``test_data_folder`` with dummy text.  
``preprocess_corpus.py`` takes in a text file and tokenizes it, additional parameter can be passed to control whether
the language should be *fake*.  
``run.sh`` will shard the text files, create vocabulary for it, create bert-readable tensorflow records, and upload to google cloud.  
``create_pretraining_data_permutation.py`` allows creating pre-training data with permuted sentences, where the permute probability and method can be freely chosen.
``frequency_based_shuffle.py`` takes in a text corpus, and shuffles such that every word is replaced by a random word from the distribution of its vocabulary.

An example run that creates data that contains English and English Fake:
```bash
./init.sh
python preprocess_corpus.py \
    --corpus test_data_folder/raw_txt/test.txt \
    --output test_data_folder/txt/en.txt
python preprocess_corpus.py \
    --corpus test_data_folder/raw_txt/test.txt \
    --output test_data_folder/txt/en-fake.txt \
    --make_fake
./run.sh
```

``run.sh`` requires a valid google cloud storage bucket to upload the data to gcloud. 
It also requires [gsutil](https://cloud.google.com/storage/docs/gsutil_install) to copy the files to the bucket.
