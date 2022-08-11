import time
import random
from pprint import pprint


def get_ordered_list_of_size(n):
    l = [random.randint(1, 1000) for i in range(n)]
    l.sort()
    return l


def current_time():
    return time.time_ns()


def isEmpty(s1):
    return len(s1) == 0


def adjoin_set(e, set) -> list:
    if isEmpty(set):
        return [e]
    elif e < set[0]:
        return [e] + set
    elif e == set[0]:
        return set
    else:
        return [set[0]] + adjoin_set(e, set[1:])


def union_set(s1, s2) -> list:
    if isEmpty(s1):
        return s2
    if isEmpty(s2):
        return s1
    return union_set(s1[1:], adjoin_set(s1[0], s2))


def get_time_of_merging_set_of_size(n):
    s1 = get_ordered_list_of_size(n)
    s2 = get_ordered_list_of_size(n)

    t1 = current_time()

    union_set(s1, s2)

    t2 = current_time()
    return t2 - t1


if __name__ == '__main__':

    records = {}
    for n in range(1, 10):
        records[n] = get_time_of_merging_set_of_size(n)

    pprint(records)
