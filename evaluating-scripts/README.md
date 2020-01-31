## Evaluating-scripts
#### Preparation (NER)
- Prepare the ner data and bert models.

You can find some of our bert models here:  
TODO  
And some NER datasets [here](https://github.com/pfliu-nlp/Named-Entity-Recognition-NER-Papers/tree/master/ner_dataset).  
We are not authorized to release the ner dataset we experimented on.  

Follow ``init.sh`` and add the current directories path to python's path.  
Set up PROJECT_MODELS and PROJECT_SCRIPTS in ``train.sh``.
Set up ner data path and bert model path in base.jsonnet.
``./train.sh 0 allennlp-config/base.jsonnet`` will execute ner training.

