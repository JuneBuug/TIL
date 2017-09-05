# 전산학특강 20170905

## Other resources
cs231이 주임 
추가적으로 듣고싶으면
Cs224n 
자연어처리 관련 : 챗봇 등 

## Textbook
안보죠?
pdf없죠?
맨날 열어만 놓죠?

## 선수조건 
파이-싼
numpy만 써서 하는 과제 있음
Numerical library죠 

## Problem Settings in ML

### Data set
* Feature( Attributes / Dimension) 
* Item  ( each data sample containing features)
* Label ( feature we want to predict using info) 

Label은 두가지임 
1. Continuous 할수있고 (키라든지…)
2. Categorical (예측하기 더 쉬움, 옵션이 있으니까 )

categorical을 예측하는게 classification 
continous를 하는게 regression

이 두가지를 합쳐서하면 
**Supervised Learning**
(Training data가 있고, target label이 있음) 

**Unsupervised Learning**
Target label 없음 

### Feature Data type
* nominal (= some set of possible names) / categorical 
* Discrete (ordinal var ) <->  Continuous 


### Supervised / UnSupervised

#### Supervised Learning
* classification
* linear regression 
* logistic regression 

Decision Tree / Neural Net  
앙상블 … 

#### Unsupervised
* categorical  => clustering ( 대표 : K-means / hierarchical clustering / 가우시안,, / graph propagation..? )
* continous var  => neural network 은 node에 따라서 어떤 var을 예측하는데 두루 쓰일 수 있음 
PCA= feature가 여러개 있을 떄 가장 중요한 feature 뽑아내는거ㅓㅓ 


* clustering
* dim red
* density estimation 
(Unseen data(test data)가 있을 때  target var를 예측하는게 ML의 내용인데)
그냥 density를 예측하고싶은게 아니라 density value for unseen data하는 것임. 
Ex) room image 예제. Own feature vector가 있는 새로운 데이터가 주어졌을 때 해당 room image는 어떻게 생겨먹었을것인지를 예측할수있음.



-

**우리 set이 feature이 없거나 data 구조가 없는 경우** 
image나 text data 등 : unstructured data라고 부름

Time / Sequential 
Ex) 알파고… sequence of possible actions한거임 
Voice (temporal data의 일종 (line graph로 나올수있으니까)

Graph / Network data
: graph mining / Convolutional Neural Network 

