import argparse
import sys
BERT_PATH="./bert/"
sys.path.append(BERT_PATH)
import tokenization
from multiprocessing.dummy import Pool as ThreadPool
import itertools

UNICODE_OFFSET = 200000

'''
If the file is too large to store in memory, split it first
'''
def transform(sentences, start_index, end_index, make_fake=False):
    tokenizer = tokenization.BasicTokenizer(do_lower_case=False)
    output = []
    if start_index != 0:
        tqdm = lambda x: x
    else:
        from tqdm import tqdm
    for line_index in tqdm(range(start_index, end_index)):
        line = sentences[line_index]
        line = line.strip()
        if len(line) == 0:
            output.append("\n")
        else:
            words = tokenizer.tokenize(line)
            if make_fake:
                words = ["".join([chr(ord(c) + UNICODE_OFFSET) for c in word]) for word in words]
            output.append(" ".join(words) + "\n")
    return output

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--corpus", required=True)
    parser.add_argument("--threads", type=int, default=12)
    parser.add_argument("--output", required=True)
    parser.add_argument("--make_fake", action="store_true")
    args = parser.parse_args()

    with open(args.corpus, "r") as fin:
        sentences = fin.readlines()

    thread_size = (len(sentences) + args.threads - 1) // args.threads
    starts = list(range(0, len(sentences), thread_size))
    ends = starts[1:] + [len(sentences)]
    pool = ThreadPool(args.threads)
    results = pool.starmap(transform, zip(itertools.repeat(sentences), starts, ends, itertools.repeat(args.make_fake)))
    with open(args.output, "w") as f:
        for result in results:
            for line in result:
                f.write(line)