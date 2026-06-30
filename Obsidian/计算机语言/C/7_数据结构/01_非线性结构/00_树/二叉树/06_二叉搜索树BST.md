---
tags: [C语言, 二叉搜索树, BST, 查找, 插入, 删除, 数据结构]
type: 知识卡片
date: 2026-06-30
cssclasses: [cards, clean-embeds]
---

# 06 | 二叉搜索树 BST：左小右大，查找有方向

> [!abstract] 核心结论  
> 二叉搜索树要求任意结点的左子树都小于当前结点，右子树都大于当前结点。它的优势是查找、插入、删除都有方向，不需要盲目遍历整棵树。

## ① 底层原理

BST 的性质：

```text
左子树所有值 < 根结点值 < 右子树所有值
```

并且左右子树也必须是 BST。

示例：

```text
        8
       / \
      3   10
     / \    \
    1   6    14
```

查找 `6`：

```text
6 < 8，去左边
6 > 3，去右边
找到 6
```

---

## ② 查找

```c
typedef struct TreeNode {
    int data;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode *searchBST(TreeNode *root, int value) {
    if (root == NULL || root->data == value) {
        return root;
    }

    if (value < root->data) {
        return searchBST(root->left, value);
    } else {
        return searchBST(root->right, value);
    }
}
```

---

## ③ 插入

```c
#include <stdlib.h>

TreeNode *createNode(int value) {
    TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
    node->data = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeNode *insertBST(TreeNode *root, int value) {
    if (root == NULL) {
        return createNode(value);
    }

    if (value < root->data) {
        root->left = insertBST(root->left, value);
    } else if (value > root->data) {
        root->right = insertBST(root->right, value);
    }

    return root;
}
```

> [!note] 代码备注  
> 这里默认 BST 不保存重复值。如果允许重复值，需要额外规定重复值放左边还是右边。

---

## ④ 验证 BST

不能只判断当前结点的左右孩子，还要限制整棵子树的范围。

```c
int isValidBSTRange(TreeNode *root, long minValue, long maxValue) {
    if (root == NULL) {
        return 1;
    }

    if (root->data <= minValue || root->data >= maxValue) {
        return 0;
    }

    return isValidBSTRange(root->left, minValue, root->data) &&
           isValidBSTRange(root->right, root->data, maxValue);
}
```

错误判断：

```text
只看 root->left < root 和 root->right > root
```

因为右子树里的所有结点都必须大于根，不只是右孩子。

---

## ⑤ 删除

删除 BST 结点分三种情况：

| 情况 | 处理 |
|---|---|
| 叶子结点 | 直接删除 |
| 只有一个孩子 | 用孩子代替自己 |
| 有两个孩子 | 找右子树最小值或左子树最大值替换 |

```c
TreeNode *findMin(TreeNode *root) {
    while (root->left != NULL) {
        root = root->left;
    }
    return root;
}

TreeNode *deleteBST(TreeNode *root, int value) {
    if (root == NULL) {
        return NULL;
    }

    if (value < root->data) {
        root->left = deleteBST(root->left, value);
    } else if (value > root->data) {
        root->right = deleteBST(root->right, value);
    } else {
        if (root->left == NULL) {
            TreeNode *right = root->right;
            free(root);
            return right;
        }

        if (root->right == NULL) {
            TreeNode *left = root->left;
            free(root);
            return left;
        }

        TreeNode *successor = findMin(root->right);
        root->data = successor->data;
        root->right = deleteBST(root->right, successor->data);
    }

    return root;
}
```

---

## ⑥ 修剪 BST / 转换累加树

```c
TreeNode *trimBST(TreeNode *root, int low, int high) {
    if (root == NULL) {
        return NULL;
    }

    if (root->data < low) {
        return trimBST(root->right, low, high);
    }

    if (root->data > high) {
        return trimBST(root->left, low, high);
    }

    root->left = trimBST(root->left, low, high);
    root->right = trimBST(root->right, low, high);

    return root;
}
```

转换为累加树：按照右、根、左的顺序遍历。

```c
void convertBST(TreeNode *root, int *sum) {
    if (root == NULL) {
        return;
    }

    convertBST(root->right, sum);
    *sum += root->data;
    root->data = *sum;
    convertBST(root->left, sum);
}
```

---

## ⑦ 重点 / 注意 / 常见错误

| 操作 | 关键点 |
|---|---|
| 查找 | 小往左，大往右 |
| 插入 | 找到空位置再插入 |
| 删除 | 分 0 个、1 个、2 个孩子讨论 |
| 验证 BST | 使用上下界范围 |
| 中序遍历 | BST 中序结果有序 |
| 累加树 | 右根左遍历 |

> [!tip] 记忆口诀  
> **左小右大，中序有序。**

---

## ⑧ 相关笔记

- [[01_二叉树基础]]
- [[02_二叉树遍历]]
- [[07_平衡树与特殊二叉树]]
