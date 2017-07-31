# iOS Concurrent Programming 

## 서론 
CPU 추이를 보면, 한동안은 무어의 법칙이 유지되면서 점점 성장세만 남은 걸로 보였었다. 
하지만 클럭 속도가 2GHz를 넘어가면서부터 옴의 법칙이 깨지면서,
또한 집적도가 높아짐에 따라 전자가 다른 전선으로 넘어가는 현상이 생기면서 기존 방식의  CPU 향상은 어렵게 되었다.  그러면서 다른 방식의 성장을 추구하기 시작했는데 그게 바로 `코어 늘리기`다.

보완필요 

기억하기로, 한 코어당 하나의 쓰레드(실행흐름)을 동작시킬 수 있다.
당연히, 여러 코어가 생김에 따라서 여러 쓰레드를 동시에 동작시킬수 있다. 
화면이 멈추지 않고 이벤트에 반응을 하면서, 뒤에서는 데이터를 받아서 ㅓ리를 해주고 싶다면 Concurrent Programming 이 필수적이다 .

기존의 Concurrent Programming은 직접적으로 Thread를 다루는 영역이었다. 하지만 쓰레드를 가지고 concurrent하게 짜는게 어렵고,
쓰레드 스케쥴링은 운영체제단에서 하는 일이어서, 무조건 많다고 효율적이지도 않았다. 더불어 운영체제가 커버해주지 않는 이상 한계가 있다.

## GCD이전의 ConcurrentProgamming의 장단점 

### 장점 

1. 화면이 멈추지 않고 이벤트에 반응을 함 
2. 병렬적으로 동작하기때문에 연산이 빠름 

### 단점 
1. 좋은 멀티쓰레드 코드를 작성하는 건 어렵다. 디버깅하기도 어렵고, 타이밍 문제가 생길 수 있어서 이후에 queueing으로 해결을 한다. 
2. 실행가능한 정도로 멀티태스킹을 하는 것의 문제점. 


## GCD (Grand Central Dispatch) 
GCD의 컨셉 이전에는 병력적으로 동시에 다른 작업할 때 Thread를 만들었다. 이제는, thread를 우리가 만드는게 아니라 OS가 알아서 처리해준다. 그 thread를 다루기 위한 단위는 closure 단위로 만들어서 작업을 넘겨주면 된다. 그 작업을 넘기는 매개는 queue가 된다. 

즉, thread 이제 신경 쓸 필요 없이, 
1. 반복적으로 백그라운드에서 불러주고 싶은 작업을 
2. Queue에 
3. Closure 단위로 넘겨주면 됨. 

### 개론 
* GCD는 오픈소스고, 리눅스에도 들어가 있다. 
* Thread 스케쥴링을 해준다. 노는 thread의 queue에 closure을 붙여주는 등의 역할을 한다. 
* 덕분에 우리는 core와 thread 갯수에 신경 안쓰고 closure단위로 작업가능함. 
* objective c에서는 closure를 block 단위라고 말함. 
* Event source개념도 있어서, event의 source에 따라 queue에 넣어줄 수 도 있음. 

### 장점
1. 효율적임 CPU 사이클 개이득! 
2. Block개념과 Queue개념 도입으로 더 이해하기 쉬움
3. 범시스템적인 시점 


### 코드 

```
func doTimeConsumingOperation(operation : Any?) {
		DispatchQueue.init(label: 		"junekim.woowa.techcamp").async { 	   //operation.doOperation()  		  print("Other thread is running...")	} }
```

DispatchQueue에 init하고 이름을 넣어주고, 그 이름에 async하게 closure를 만들어서 넘기면, 이 queue에 붙은 thread가 잡혀서 실행됨.  


### Locking
원래 하나의 resource를 여러 쓰레드가 사용하려고 할 때는  semaphore나 mutex를 설정해야함. 

하지만 sync함수나 async 함수는 lock이 필요 없음. 
같은 것의 접근에 대해서, 같은 queue하면 순서대로 되니까!
locking이 걸려있는 역할을 한다. 
하지만 같은 resource 에 대해서  다른 queue를 넣으면 mutual exclusion 이 보장되기가 어려움! 


### DispatchQueue 종류 

```

DispatchQueue.main.async(){
}
DispatchQueue.main.sync(){
}
# main 쓰레드에서 기다림. 화면이 멈출수도 있음. 기다리는 것 자체가 의미 있는 경우에만 해야함! 네트워크 가져오는 것 안됨. 

DispatchQueue.main.asyncAfter(deadline: .now() + milliseconds(500)){
}
# 특정시간으로부터 몇초 뒤에 실행해줘! 

DispatchQueue.global().async{
}
# Global Queue를 가져오기!
# global queue 공통적인 큐를 하나 말함. 어떤 쓰레드가 될진 모르고, 놀고있는 쓰레드 아무거나. 

# Alamofire / URLSession 같은건 GCD를 써서 async로 동작함! 두번 할 필요가 없음.  
```

#### Queue API
```
func async(group: DispatchGroup? = default,           qos: DispatchQoS = default,           flags: DispatchWorkItemFlags = default,           execute work: @escaping @convention(block) () -> Swift.Void)func sync(execute block: () -> Swift.Void) ✱ 

# grouping을 해서, 얘 / 얘 / 얘 함수가 끝나면 끝난거야! 라고 지정
# 선택하지않아도 default로 넘겨주는게 있음
# qos 우선순위 조정 

func asyncAfter(deadline: DispatchTime,            qos: DispatchQoS = default,            flags: DispatchWorkItemFlags = default,            execute work: @escaping @convention(block) () -> Swift.Void)# 블록을 나중에 넣는다.  class func concurrentPerform(iterations: Int, execute work: (Int) -> Swift.Void)
# for문을 대신해서 반복적으로 동작하는 closure를 만들 수 있음.
```

Queue는, 멈추거나 다시 사용하는 수 밖에 없음.
그 안에 넣은 task가 취소가 안됨. 

```
suspend()
# 멈춤
resume()
# 재시작
```

등을 사용해서 잘 조절하도록 하자.



## 실제에서는 어떻게 쓰는지 
collectionview의 cell을 그려주는데, 이 cell 안에 있는 image를 url에서 받아와야하는 일이 생겼다.  cache에 이 이미지가 있으면 그냥 넣어주고, 아니면 cell을 그려줄때마다 해당하는 url에서 image를 받아오는 함수를 async하게 넣어주었다. 

image를 받아오고 나서는 notification을 받아서 그 cell을 reload해주면 끝!
하지만 reload할 때도 DispatchQueue의 main 쓰레드에서 업데이트 해주어야한다.

