---
tags: [C语言, 二叉搜索树, BST, 查找, 插入, 删除, 数据结构]
type: 知识卡片
date: 2026-06-30
cssclasses: [cards, clean-embeds]
---

# 01 | BST 基本性质：左小右大

> [!abstract] 核心结论  
> 二叉搜索树要求左子树所有值小于根，右子树所有值大于根。

## ① 底层原理

BST 的左右子树也必须满足同样性质，因此它是递归定义的。

---

## ② 基本语法 / 代码用法

```c
typedef struct TreeNode {
    int data;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;
```

---

## ③ 含义 / 说明

```text
BST 仍然使用普通二叉树结点结构，只是数据排列有额外规则。
```

---

## ④ 输出

```text
无固定输出，重点看函数返回值或树结构变化。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：只比较左右孩子，不比较整棵左右子树。

> [!tip] 记忆口诀  
> **左小右大，子树也一样。**

---

# 02 | BST 查找：小往左，大往右

> [!abstract] 核心结论  
> 查找时每次可以排除一半方向，不需要遍历整棵树。

## ① 底层原理

目标值小于当前结点就去左子树，大于当前结点就去右子树。

---

## ② 基本语法 / 代码用法

```c
TreeNode *searchBST(TreeNode *root, int value) {
    if (root == NULL || root->data == value) return root;
    if (value < root->data) return searchBST(root->left, value);
    return searchBST(root->right, value);
}
```

---

## ③ 含义 / 说明

```text
找到返回结点地址；找不到最终走到 NULL。
```

---

## ④ 输出

```text
找到返回非 NULL，找不到返回 NULL。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：BST 查找还左右都递归，浪费了 BST 性质。

> [!tip] 记忆口诀  
> **小左大右，一路单走。**

---

# 03 | BST 插入：找到空位置接上新结点

> [!abstract] 核心结论  
> 插入 BST 时，按照查找路径找到 NULL 位置，然后创建新结点。

## ① 底层原理

新值小于当前结点插入左子树，大于当前结点插入右子树。

---

## ② 基本语法 / 代码用法

```c
TreeNode *insertBST(TreeNode *root, int value) {
    if (root == NULL) return createNode(value);
    if (value < root->data) root->left = insertBST(root->left, value);
    else if (value > root->data) root->right = insertBST(root->right, value);
    return root;
}
```

---

## ③ 含义 / 说明

```text
递归返回新的子树根，所以要赋值给 root->left 或 root->right。
```

---

## ④ 输出

```text
无固定输出，重点看函数返回值或树结构变化。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：递归插入后不接回 root->left/root->right。

> [!tip] 记忆口诀  
> **插入要接回父结点。**

---

# 04 | BST 中序遍历：结果有序

> [!abstract] 核心结论  
> BST 的中序遍历会得到递增序列。

## ① 底层原理

中序是左根右，而 BST 满足左小根中右大，所以输出有序。

---

## ② 基本语法 / 代码用法

```c
void inorder(TreeNode *root) {
    if (root == NULL) return;
    inorder(root->left);
    printf("%d ", root->data);
    inorder(root->right);
}
```

---

## ③ 含义 / 说明

```text
这是判断和利用 BST 性质的重要工具。
```

---

## ④ 输出

```text
BST 中序输出升序。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：忘记 BST 中序有序这个核心性质。

> [!tip] 记忆口诀  
> **BST 加中序，天然升序。**

---

# 05 | 验证 BST：使用上下界

> [!abstract] 核心结论  
> 验证 BST 不能只看当前左右孩子，必须用范围限制整棵子树。

## ① 底层原理

左子树所有结点都必须小于根，右子树所有结点都必须大于根。

---

## ② 基本语法 / 代码用法

```c
int valid(TreeNode *root, long low, long high) {
    if (root == NULL) return 1;
    if (root->data <= low || root->data >= high) return 0;
    return valid(root->left, low, root->data) &&
           valid(root->right, root->data, high);
}
```

---

## ③ 含义 / 说明

```text
low 和 high 表示当前结点允许出现的值范围。
```

---

## ④ 输出

```text
合法返回 1，不合法返回 0。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：只判断 root->left->data < root->data。

> [!tip] 记忆口诀  
> **验证 BST，看整段范围。**

---

# 06 | 查找最小值和最大值：一路向左或向右

> [!abstract] 核心结论  
> BST 最小值在最左下角，最大值在最右下角。

## ① 底层原理

因为左边都更小，所以一直向左能找到最小值。

---

## ② 基本语法 / 代码用法

```c
TreeNode *findMin(TreeNode *root) {
    while (root != NULL && root->left != NULL) root = root->left;
    return root;
}
```

---

## ③ 含义 / 说明

```text
findMax 同理，把 left 改成 right。
```

---

## ④ 输出

```text
返回最小值结点地址。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：在普通二叉树中也这样找最小值。这个方法只适用于 BST。

> [!tip] 记忆口诀  
> **最小一路左，最大一路右。**

---

# 07 | BST 删除：分三种情况

> [!abstract] 核心结论  
> 删除结点要分叶子、一个孩子、两个孩子三种情况处理。

## ① 底层原理

两个孩子时，通常用右子树最小值或左子树最大值替代当前结点。

---

## ② 基本语法 / 代码用法

```c
TreeNode *deleteBST(TreeNode *root, int value) {
    if (root == NULL) return NULL;
    if (value < root->data) root->left = deleteBST(root->left, value);
    else if (value > root->data) root->right = deleteBST(root->right, value);
    else {
        if (root->left == NULL) return root->right;
        if (root->right == NULL) return root->left;
        TreeNode *s = findMin(root->right);
        root->data = s->data;
        root->right = deleteBST(root->right, s->data);
    }
    return root;
}
```

---

## ③ 含义 / 说明

```text
这段代码省略 free，实际写完整程序时要释放被删除结点。
```

---

## ④ 输出

```text
无固定输出，重点看函数返回值或树结构变化。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：删除有两个孩子的结点时直接丢掉一棵子树。

> [!tip] 记忆口诀  
> **删 BST，三情况。**

---

# 08 | 修剪 BST：利用范围剪枝

> [!abstract] 核心结论  
> 修剪 BST 只保留指定范围内的结点，可以利用 BST 性质跳过无效子树。

## ① 底层原理

如果当前值小于 low，左子树更小，也应全部丢弃。

---

## ② 基本语法 / 代码用法

```c
TreeNode *trimBST(TreeNode *root, int low, int high) {
    if (root == NULL) return NULL;
    if (root->data < low) return trimBST(root->right, low, high);
    if (root->data > high) return trimBST(root->left, low, high);
    root->left = trimBST(root->left, low, high);
    root->right = trimBST(root->right, low, high);
    return root;
}
```

---

## ③ 含义 / 说明

```text
只有当前结点在范围内，才继续修剪左右子树。
```

---

## ④ 输出

```text
无固定输出，重点看函数返回值或树结构变化。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：不利用 BST 性质，整棵树盲目遍历。

> [!tip] 记忆口诀  
> **小了去右，大了去左。**

---

# 09 | 转换累加树：右根左遍历

> [!abstract] 核心结论  
> BST 转累加树要从大到小累加，因此使用右、根、左遍历。

## ① 底层原理

BST 中序是升序，反中序就是降序。累加树需要先处理更大的值。

---

## ② 基本语法 / 代码用法

```c
void convertBST(TreeNode *root, int *sum) {
    if (root == NULL) return;
    convertBST(root->right, sum);
    *sum += root->data;
    root->data = *sum;
    convertBST(root->left, sum);
}
```

---

## ③ 含义 / 说明

```text
sum 保存已经访问过的更大结点之和。
```

---

## ④ 输出

```text
无固定输出，重点看函数返回值或树结构变化。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：按左根右遍历，累加方向反了。

> [!tip] 记忆口诀  
> **累加树，右根左。**

---

# 10 | BST 主题总结：性质决定方向

> [!abstract] 核心结论  
> BST 的所有操作都围绕左小右大展开，方向判断是效率来源。

## ① 底层原理

查找、插入、删除、修剪都可以根据当前值和目标值比较决定往哪边走。

---

## ② 基本语法 / 代码用法

```c
if (value < root->data) {
    // 去左子树
} else {
    // 去右子树
}
```

---

## ③ 含义 / 说明

```text
这就是 BST 与普通二叉树最大的区别。
```

---

## ④ 输出

```text
无固定输出，重点看函数返回值或树结构变化。
```

---

## ⑤ 重点 / 注意 / 常见错误

常见错误：把 BST 当普通二叉树做，失去有序性优势。

> [!tip] 记忆口诀  
> **BST 的灵魂，是方向。**

---

