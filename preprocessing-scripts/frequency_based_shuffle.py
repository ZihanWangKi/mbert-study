import argparse
import os
from collections import Counter
from tqdm import tqdm
import numpy as np
import time


def apply(filename, outfile):
    counter = Counter()
    total_words = 0
    line_words = []
    with open(filename, 'r') as fin:
        for line in tqdm(fin):
            words = line.split()
            counter.update(line.split())
            total_words += len(words)
            line_words.append(len(words))
    word_list, frequency_list = list(zip(*counter.items()))
    print(len(word_list))
    print(total_words)
    frequency_list = np.array(frequency_list) / sum(frequency_list)
    start = time.time()
    sample_words = list(np.random.choice(word_list, size=total_words, p=frequency_list))
    end = time.time()
    print("Creating random samples cost {}s".format(end - start))
    c_start = 0
    with open(outfile, 'w') as fout:
        for count in tqdm(line_words):
            fout.write(" ".join(sample_words[c_start: c_start + count]))
            fout.write("\n")
            c_start += count

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--corpus", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    assert os.path.exists(os.path.dirname(args.output.rstrip("/"))), "Parent directory of output does not exist"

    apply(args.corpus, args.output)
