from __future__ import print_function
from rcviz import CallGraph, viz


def is_null(tree):
    return tree == []


def cons(e, l):
    return [e] + l


def append(l1, l2):
    return l1 + l2


def left_branch(tree):
    return tree[1]


def entry(tree):
    return tree[0]


def right_branch(tree):
    return tree[2]


cg1 = CallGraph(filename="to-list-1.png")


@viz(callgraph=cg1)
def tree_to_list1(tree):
    if is_null(tree):
        return []
    else:
        return append(tree_to_list1(left_branch(tree)),
                      cons(entry(tree),
                           tree_to_list1(right_branch(tree))))


cg2 = CallGraph(filename="to-list-2.png")


@viz(callgraph=cg2)
def copy_to_list(tree, result_list):
    if is_null(tree):
        return result_list
    else:
        return copy_to_list(left_branch(tree),
                            (cons(entry(tree),
                                  copy_to_list(right_branch(tree), result_list))))


def tree_to_list2(tree):
    return copy_to_list(tree, [])


if __name__ == '__main__':
    # tree = [1,
    #         [2, [], []],
    #         [3, [], []]]

    tree = [7,
            [3, [1, [], []], [5, [], []]],
            [9, [], [11, [], []]]]
    print(tree_to_list1(tree))
    cg1.render()

    print(copy_to_list(tree, []))
    cg2.render()
