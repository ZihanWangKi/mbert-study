# mBERT-Study
<h5 align="center">CROSS-LINGUAL ABILITY OF MULTILINGUAL BERT: AN EMPIRICAL STUDY</h5>

## Motivation 

TODO

## Results

TODO

## Scripts

#### Creating pre-training data
###### Preparation
- Wikipedia text data if training from scratch. (TODO, put our scripts here as well)  

We first provide a basic usage of our scripts.
``init.sh`` will clone the official BERT repo, and create a ``test_data_folder`` with dummy text.
``preprocess_corpus.py`` takes in a text file and tokenizes it, additional parameter can be passed to control whether
the language should be __fake__.
``run.sh`` will shard the text files, create vocabulary for it, create bert-readable tensorflow records, and upload to google cloud.

An example run that creates data that contains English and English Fake:
```bash
./init.sh
python preprocess_corpus.py --corpus test_data_folder/raw_text/test.txt --output test_data_folder/txt/en.txt
python preprocess_corpus.py --corpus test_data_folder/raw_text/test.txt --output test_data_folder/txt/en-fake.txt --make_fake
./run.sh
```

#### Pre-training BERT
###### Preparation
- Google Cloud Bucket Storage
- Google Cloud Instance
- Google Cloud Tpu

When creating a google cloud instance, make sure full api access is turned on.  
In a google cloud instance, run ``init-gcloud-server.sh``.
Running ``run.sh`` initiates bert training.

#### Evaluating
- TODO
 

## Citation
Please cite the following paper if you find our paper useful. Thanks!

>Karthikeyan K, Zihan Wang, Stephen Mayhew, Dan Roth. "Cross-Lingual Ability of Multilingual BERT: An Empirical Study" arXiv preprint arXiv:1912.07840 (2019).

```
@article{,
  title={Cross-Lingual Ability of Multilingual BERT: An Empirical Study},
  author={K, Karthikeyan and Wang, Zihan and Mayhew, Stephen and Roth, Dan},
  journal={arXiv preprint arXiv:1912.07840},
  year={2019}
}
```
