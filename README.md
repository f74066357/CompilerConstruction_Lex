# CompilerConstruction_Lex
---
*Lex是一個產生語法分析器(Parser)的程式，常常與yacc 語法剖析器產生程式一起使用*
 - lex的工作主要是幫助我們將輸入的資料文字串流分解成一個個有意義的標記(token)，也就是處理構詞學(morphology)上的問題。
   - Generates C code for a **lexical analyzer**, or **scanner**
   - Uses patterns that match strings in the input and **converts the strings to tokens**
 - yacc的工作主要是幫我們分析這些標記和我們定義的規則作匹配，也就是處理句法學(syntax)上的問題。
   - Generates C code for **syntax analyzer**, or **parser**
   - Uses grammar rules that allow it to **analyze tokens** from Lex and **create a syntax tree**

---
  Lex 是一種生成掃描器(Scanner)的工具，主要功能是**切出所有的token**。掃描器是一種識別文本中字串樣式(pattern)的程式，這些字串樣式在一種特殊的句構中定義，該句構稱為**Regular Expression**。

  當 Lex 接收到文本輸入時，他會試圖將文本與正則表達式進行匹配。 **它一次讀一個字符，直到找到一個匹配的樣式。**  如果能夠找到一個匹配的樣式，Lex就執行相關的動作，而這個動作通常包括返回一個標記。如果沒有可以匹配的正則表達式，將會停止進一步的處理，Lex 將顯示一個錯誤消息。
  
The input (.l) is translated to a C program (lex.yy.c)

---
## lex.l is divided into 3 parts:
1. 定義區 : lex載入定義檔為我們產生字彙剖析器的程式碼時，會原封不動的把這一區塊個的程式碼複製過去，而不會對這部份程式碼作任何處理。初始化C和lex，比如變數的宣告。
    - Defs, Constants, Types, #includes, etc. that can occur in a C Program
    - Regular Definitions (expressions)
2. 樣式區 : 主要區塊，放置正則表達式定義的樣式以及對應的動作程式碼。定義pattern與相對應的action。
    - Pairs of (Regular Expression, Action)
    - Informs lexical analyzer of action when pattern is recognized
3. 程式碼區 : 和定義區一樣，lex在最後為我們產生字彙剖析器(parser)的程式碼時也會原封不動的複製過去，而不作任何處理。
    - Designer Defined C Code
    - E.g., symbol table codes
---
## 編譯 & 執行
```c=
flex test.l
```
```c=
gcc yy.lex.c -o test
```
```c=
./test < input.txt
```
---
## 函數
![](https://i.imgur.com/lmHU5gQ.png)

---
## Regular expression in LEX
---
- STRING 

```\"([^\\\"]|\\.)*\"```

![](https://i.imgur.com/JR1Ec9g.png)

- COMMENT

1.```("//")[^\n\r]*```

2.```"/*"([^*]|\*+[^*/])*\*+"/"```
This matches 0 or more "anything except *" OR "1 or more *s not followed by a * or /" inside the comment markers.

---
## Check answer

```=
make
```
```=
gcc lex.yy.c -ll
```
```=
./a.out < input/in01_arithmetic.go
```
```=
python3 judge/judge.py
```
---
###### tags: `Compiler HW`
