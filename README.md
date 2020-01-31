# M-BERT-Study
<h5 align="center">CROSS-LINGUAL ABILITY OF MULTILINGUAL BERT: AN EMPIRICAL STUDY</h5>

## Motivation 

[Multilingual
BERT](https://github.com/google-research/bert/blob/master/multilingual.md) (M-BERT) has shown surprising cross lingual abilities --- even when it is trained without cross lingual objectives.
In this work, we analyze what causes this multilinguality from three factors: linguistic properties of the languages, the architecture
of the model, and the learning objectives.

## Results

Linguistic properties:
- Code switching text (word-piece overlap) is **not** the main cause of multilinguality.
- Word ordering is crucial, when words in sentences are randomly permuted, multilinguality is low, however, still significantly better than random.
- (Unigram) word frequency is not enough, as we resampled all words with the same frequency, and found almost random performance.
Combining the second and the third property infers that there is language similarity other than ordering of words between two languages, and which unigram frequency does not capture. 
We hypothesize that it may be similarity of n-gram occurrences.

Architecture:
- Depth of the transformer is the most important.
- Number of attention heads effects the absolute performance on individual languages, but the gap between in-language supervision and cross-language zero-shot learning didn't change much.
- Total number of parameters, like depth, effects multilinguality.

Learning Objectives:
- Next Sentence Prediction objective, when removed, leads to slight increase in performance.
- Even marking sentences in languages with language-ids, allowing BERT to know exactly which language its learning on, did not hurt performance
- Using word-pieces leads to strong improvements on both source and target language (likely to depend on tasks) and slight improvement cross-lingually comparing to word or character based models.

## Scripts

#### Creating pre-training data

If you would like to pre-train a BERT with Fake language/permuted sentences, see [preprocessing-scripts](preprocessing-scripts)
for how to create the tfrecords for BERT training.

#### Pre-training BERT

Once you have uploaded the tfrecords to google cloud, you can set up an instance and start BERT training via [bert-running-scripts](bert-running-scripts).

#### Evaluating

With models we provide or just trained, we provide code for evaluating on two tasks, NER and entailment. See [evaluating-scripts](evaluating-scripts).
 

## Citation
Please cite the following paper if you find our paper useful. Thanks!

>Karthikeyan K, Zihan Wang, Stephen Mayhew, Dan Roth. "Cross-Lingual Ability of Multilingual BERT: An Empirical Study" arXiv preprint arXiv:1912.07840 (2019).

```
@article{wang2019cross,
  title={Cross-Lingual Ability of Multilingual BERT: An Empirical Study},
  author={K, Karthikeyan and Wang, Zihan and Mayhew, Stephen and Roth, Dan},
  journal={arXiv preprint arXiv:1912.07840},
  year={2019}
}
```
