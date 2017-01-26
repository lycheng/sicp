SICP 第一章
===

前言
---

这里是关于 SICP 第一章的读书笔记以及一些练习答案。

程序的组成
---

在程序中，我们与两种元素打交道，`procedures` 和 `data`。通过前者去操作后者。

程序语言都包含以下三个部分

1. 表达式，语言的最小单位
2. 组合，从更小的元素（表达式）而来
3. 抽象，包含不同的元素并且能整体调用

### 实例

```
(+ 21 35 12 7)
```

对于上述代码，每一个括号内的元素就是表达式，`+` 号是操作符，数字是操作数。括号内的元素的顺序就是组合，同时，这也是表达式，只不过是一种复合表达式。

```
// 嵌套组合
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

// 这样好看点
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))
```

命名
---

```
(define pi 3.14159)
```

变量的命名用 `define` 关键字，通过 name 去引用复杂类型，这里就是最简单的抽象。但这 **不是组合**。

### procedure 定义

```
(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
```

即常见的函数定义。在解析的过程中，通过 `substitution model` 的方法去执行对应的非内置的 `procedure` 来获取该表达式的值。

#### applicative-order evaluation

解析模型 `applicative-order evaluation`，即先执行所有的子表达式，优先处理参数

```
(f 5)
(sum-of-squares (+ a 1) (* a 2))
(sum-of-squares (+ 5 1) (* 5 2))
(+ (* 6 6) (* 10 10))
(+ 36 100)
```

#### normal-order evaluation

另一种解析模型 `normal-order evaluation`，即竭尽所能展开表达式再合并，跟前一种模型相比，这里着重于先替换所有的自定义 `procedure`

```
(f 5)
(sum-of-squares (+ 5 1) (* 5 2))
(+    (* (+ 5 1) (+ 5 1))   (* (* 5 2) (* 5 2)))
(+ (* 6 6) (* 10 10))
(+ 36 100)
```

这里它直接将参数替换，接着开始替换自定义的 `procedure` 最后再执行只包含内置 `procedure` 的表达式。

lisp 使用第一种替换模型。

条件
---

```
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (abs x)
  (if (< x 0)
      (- x)
      x))k
      
(and (> x 5) (< x 10))
(or (> a 1) (< a 10))
```

这里有个有趣的代码

```lisp
(if (> 1 0) + -)
;Value 13: #[arity-dispatched-procedure 13]
```

上述的 `Value 13` 是指 `+`，即在 `scheme` 中，它是一个 `procedure` 而不是操作符。所以，我们可以定义我们自己的 `>=` `procedure`

```
(define (>= x y)
  (or (> x y) (= x y)))
```

黑盒抽象
---

我们不关心 `procedure` 的具体实现，我们只关心输入和输出。

### local names

黑盒抽象的前提是，`procedure` 的实现与参数无关，即实参和形参的关系。`procedure` 定义的参数的作用域就在该 `procedure` 本身。

对于在外部定义的 `procedure` 或者变量，如果将其作为形参来定义新的 `procedure`，则该参数则会覆盖（屏蔽）外部的 name。

### Internal definitions and block structure

```
(define (f a)
  (define (g a) (* 2 a))
  (g a))
```

上述的 `procedure` 的定义，`g` 是定义在 `f` 内部的，这种嵌套的写法叫 `block structure`。用于不同的 `procedure` 定义自身的 `g` 来实现定制化的功能。

因为 `a` 的作用域在 `f` 内，并且定义的 `g` 也在 `f` 内，所以这里也不需要进行传参数即可使用。

```
(define (f a)
  (define (g) (* 2 a))
  (g))
```

线性递归和线性迭代
---

对于斐波那契数列

```
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

这种解法，根据 n 的不断变化，执行的步骤如下

```
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
...
```

另一种解法

```
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
```

执行的步骤如下

```
(fact-iter 1 1 6)
(fact-iter 1 2 6)
...
```

上面两种解法，前者是递归，后者是迭代。两者的主要区别在于中间步骤，地柜的情况下，解析器需要保持其以前的计算结果，而后者的中间步骤的需要的参数已经确定，与之前的步骤已经没有关系。

树型递归
---

```
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

在递归的过程中，`fib` 会出现分支 `(fib (- n 1))` 和 `(fib (- n 2))`。每一个更上层的调用会分裂成 2 个参数更小的调用，直到 n <= 1。最终的调用顺序会变成一棵树。在这些计算中，会明显出现重复计算的时候。

### 例子：Counting change

边界条件

 1. A （当前金额）等于 0 ，则有 1 种换法
 2. A 小于 0，则有 0 种换法
 3. 当 N（可选择的货币面值）为 0 则有 0 种换法

递归的条件

 1. 不使用 x 这种货币的情况下的换法
 2. 使用 x 这种货币的情况下，A - X（X 为 x 的面值）的换法

增长的阶
---

用 n 来描述问题的规模，则 R(n) 表示求该问题所需要用的资源。即常见的问题复杂度。

例子：查找最小除数
---

对于需要查找的数 n，测试除数 d 从 2 开始

1. 如果 d^2 大于 n 则 n 的最小除数是自身，即质数
2. 如果 d 可以整除 n 则 d 为 n 的最小除数
3. d = d + 1 并重复测试上面的步骤

这个过程的复杂度为 `根号n`。

例子：费马小定理
---

如果 n 是一个质数，存在 a 是一个小于 n 的整数，则 a^n 和 a 对 n 同余，即 `a^n % n == a`

> 两个整数 a, b，若他们除以正整数 m 所得的余数相同，则称 a, b 对模 m 同余。

用来求 a^n 模 n 的 `procedure`

```
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
```

之后用一个小于 n 的随机数来测试 n 是否是质数

```
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
```

最终的代码

```
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
```

可以看出，该算法仅仅是在可能的条件下证明这个 n 是质数，如果要提高精度需要加大 times 变量。也并不保证 random 这个 procedure 能在每次调用的时候都是新的随机数。所以，这种算法仅仅是 **可能正确**。

高级 Procedures
--

以 `procedure` 作为参数传入 `procedure`，接收这个参数的 `procedure` 称作 `higher-order procedure`。下面的例子

```lisp
(define (inc a) (+ a 1))
(define (f a op)
  (op a)
  )

(display (f 10 inc))
; 11
```

在 `procedure` 的参数里面，`procedure` 参数和普通参数是 **没有区分** 的。

### Lambda

在上述的例子中，其实加一的操作的 `procedure` 的定义不是特别重要，可能仅仅在 f 中有使用，这里可以简单的定义匿名的 `procedure` 来使用这些这些功能

```
(display (f 10 (lambda (x) (+ x 1)))
```

### let 声明局部变量

```
(define (f x y)
  (let ((a (+ x y))
        (b (* x y)))
    (+ a b)))
```

需要注意的是，相关局部变量是有使用的范围的即

```
(let ((<var1> <exp1>)
      (<var2> <exp2>)
      
      (<varn> <expn>))
   <body>)
```

上述定义的变量只能在 body 的范围使用。这里有两点需要注意下

1. 如果是与外部变量同名，则临时变量会屏蔽外部变量
2. 如果定义中含有同名外部变量，则室外外部的值来计算临时变量的定义

对于下面的代码，x 的值为 2 则，表达式的值为 12

```
(let ((x 3)
      (y (+ x 2)))
  (* x y))
```

### procedure 作为返回值

之前可以通过参数传递 `procedure`，同理，也可以通过返回值来传递 `procedure`。

```
(define (average x y)
  (/ (+ x y) 2)
  )

(define (average-damp f)
  (lambda (x) (average x (f x)))
  )

((average-damp square) 10)
```

`procedure` 这些属性，称作 `first-class`，即

1. 可作为变量
2. 可作为别的 `procedure` 的参数
3. 可作为别的 `procedure` 的返回值
4. 可作为数据结构的一部分

  
练习
---

### Exercise 1.4

```
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

上述代码中 `if (> b 0)` 的判断最后会返回 `+` 或者 `-`。这个表达式的值最后变成一个 `procedure` 的 `operator`。

### Exercise 1.5

```
(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))
```

对于 `applicative-order evaluation` 会不断地替换 `(p)` 变成 `(p)` 以至于陷入死循环。`scheme` 则是采用了这种求值。

```
(test 0 (p))
(test 0 (p))
...
```

对于另一种，则因为布尔代数的运算躲过一劫

```
(test 0 (p)) 
(if (= 0 0) 0 (p)) 
(if #t 0 (p)) 
0
```

### Exercise 1.6

在尝试使用 `new-if` 写成的 `sqrt` 的时候，发现

```
;Aborting!: maximum recursion depth exceeded
```

原因在于 `new-if` 中 `if` 和 `else` 的分支都是要被执行的，导致 `procedure` 永远递归没有结束

```lisp
1 ]=> (new-if (> 1 0) (display "if") (display "else"))
elseif
```

跟踪代码

```lisp
(trace sqrt-iter)

[Entering #[compound-procedure 13 sqrt-iter]
    Args: 3.
          9]
[Entering #[compound-procedure 13 sqrt-iter]
    Args: 3.
          9]
... more
```

### Exercise 1.7

原来的 0.001 的精度对于小数来说太大了，导致递归太早结束。对于太大的数，这个值过小而难以终止。这里可以改变策略，当上一次尝试和今次尝试的变化过小的时候就可以终止递归。

### Exercise 1.9

对于

```
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
```

```
(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
```

对于

```
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
```

```
(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 8)
8
```

前者是递归，后者是迭代。

### Exercise 1.10

```
(A 1 10) = 1024
(A 2 4) = 65536
(A 3 3) = 65536

(define (f n) (A 0 n)) = 2n
(define (g n) (A 1 n)) = 2^n
(define (h n) (A 2 n)) = 连续的求 N 次 2 的 2 次幂
```

### Exercise 1.14

略

### Exercise 1.15

```
(sine 12.15) 
(p (sine 4.05)) 
(p (p (sine 1.35))) 
(p (p (p (sine 0.45)))) 
(p (p (p (p (sine 0.15))))) 
(p (p (p (p (p (sine 0.05)))))) 
(p (p (p (p (p 0.05))))) 
```

则执行了 5 次 `p`。因为在 `sine` 中，每次都会除以 3，则该 procedure 的复杂度为 `O(log x)`。

### Exercise 1.20

就 `applicative-order evaluation` 而言，解析过程如下

```
(gcd 206 40)
(gcd 40 6)
(gcd 6 4)
(gcd 4 2)
(gcd 2 0)
```

一共就 5 次 remainder 的调用。而 `normal-order evaluation` 会竭尽所能展开表达式，所以会更加多地调用 remainder

### Exercise 1.21

```
(smallest-divisor 199) = 199
(smallest-divisor 1999) = 1999
(smallest-divisor 19999) = 7
```

### Exercise 1.22

最后的运算的确是约等于 `根号10` 的时间消耗，但书上给的小数据根本没法得出时间差距。后来不断将数据加大才看得出来

```
(timed 10000000 3)
(timed 100000000 3)
(timed 1000000000 3)
(timed 10000000000 3)
(timed 100000000000 3)
```

### Exercise 1.23

最终的计算结果并没有 50% 的提升，我测试在 20% 左右。网站的资料有说可能是 `next` 的调用造成的，相比简单的加法这个的确会更耗时间。但没有比较官方的说法。

### Exercise 1.24

使用 `fast-prime?` 的算法，最开始的 times 指定的是目标数的一半，导致长时间无法出结果。后来改成固定的值之后发现，最后时间消耗的差异不能反映出数据规模的差异。有可能较小的数会比较大的数更耗时。

费马测试的部分代码的复杂度增长有不稳定的情况，推测是随机数的问题。选的 128 个测试的随机数如果不能保证随机，则可能导致程序耗时不稳定。

### Exercise 1.25

理论可行，但实际上会因为数据过大时间消耗不同。

`fast-expt` 可能最终会算出一个超大中间值，相比之下 `expmod` 展开后一直会在一个小数据下进行运算。

### Exercise 1.26

相比 `(square (expmod base (/ exp 2) m)`，使用 `*` 的形式会更加耗时。因为每次使用 `*` 求值，必须对两个乘数进行求值。而相比之下 `square` 的形式只会求一次，再用这个值进行求值。这样一来，计算量就从原来的 `O(logn)` 变成了 `O(n)`。

### Exercise 1.34

`procedure` 的解析过程如下

```
(f f)
(f 2)
(2 2)
```

因为 2 不能调用，则在这里报错。

总结
---

这篇文章是 SICP 的第一章的一些笔记，更多是 mit-scheme 的语法的介绍。

更多是一些以前接触过的东西的一些东西（如高阶函数）的 mit-scheme 的实现。看起来还是挺有意思的，前缀表达式的写法真挺反人类的。

参考
---

1. [Chapter 1](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-9.html#%_chap_1)
2. [习题解答](http://community.schemewiki.org/?sicp-solutions)
