# AWS 에 대해서

Amazon이라는 회사는 !
1995년 제프 베조스가 설립한 인터넷 서점이다.
인터넷 서점을 운영하며 쌓인 인프라를 가지고, 아마존은
2006년 클라우드 서비스를 시작했다.

클라우드 서비스는 직원이 적고 서비스 사용자가 많을 때 아주 유리하다!
클라우드를 사용해야하는 이유는 명백하다.  **속도에서의 혁신** 이다. 만약 미국에서 서비스를 한다고 생각하자. 서버의 속도는 물리적 거리에 영향을 받으므로, 현지에 서버에 세운다. 실제 물리 서버를 구축하는 데 걸리는 시간은 최소 1달이 걸린다.
하지만 AWS의 인스턴스를 사용하면 5분도 걸리지 않는다.


## 주요 용어
* 리전 : 데이터센터(서버건물)이 2개 이상 있는 곳
* 가용영역: 데이터센터
* 에지(PoP) 로케이션 : AWS의 CDN 서비스인 CloudFront를 위한 캐시 서버.
CDN은, 링크 주소는 하나지만 전 세계에 저장소가 분리되어있어 같은 url로 빠르게 받을 수 있다. 그 분리된 저장소를 에지 로케이션이라고 한다. 주로 사람들이 많은 대도시에 몰려있다.

## 웹 백엔드 구조

보안에 취약하기 때문에, 기본적으로는 웹 서버단을 three-tier architecture로 설계한다. 항상 Webserver => WAS(Web Application Server) => DB(Database) 순으로 접근한다.

이 세가지를 한 컴퓨터에 설치하는 건 절대 안되는 일이고, DB가 가장 중요하므로 DB는 두개 정도 쓰는게 기본이다.

![web_3_tier_archiecture](.screentshots/web_3_tier_architecture.png)

위의 그림을 보자.
DB는 기본적으로 Primary DB와 통신을 한다.
Standby는 Primary의 복제본이다.
만약 Primary가 망가진다면, Standby는 재빨리 Primary 역할을 하고, 또 하나를 복제해서 새로운 Standby를 만들어두어야한다.

Read-replica는 Primary 읽기만 되고 쓰기가 안되게 복제한 것이다.
부하가 너무 과중할 때 RR은 읽기 부하를 담당하는 역할을 한다.

백업은 하루에 한번 정도 한다.

## AWS 활용하기
* Multi AZ 를 통한 고가용성 확보

**서버는 한대로 서비스를 하면 안된다.**
하나가 죽으면 다른게 서비스가 되어야하니, 서버는 두개 이상을, 다른 곳에 두어야한다. 그래서 AWS에서는 AZ를 두개를 쓴다.

* VPC, 보안 그룹 등을 활용한 보안 향상.

AWS는 VPC라는 네트워크망을 쓴다. 여기서 네트워크 망은 스위치 꽂고 랜선 꽂고 하는 등의 기본적인 세팅을 의미한다.
또한, 보안그룹은 서버 포트(논리적인 개념)을 조절하는 역할을 한다. 어떤 포트를 열고 닫아줄지 결정하는 것. db mysql 포트는 웹서버에만 열어준다든지, ssh 포트 등은 회사 ip에만 열어둔다든지 하는 것들이 해당한다.

* 리전간 데이터 복제
한 리전을 못믿어서 하는 것. 100%에 가까운 가동률을 보장하고 싶을 때 사용한다.

* 에지 로케이션을 활용한 응답성 향상

* 타 벤더사의 플랫폼을 활용한 더 높은 가용성 확보
넷플릭스는 AWS가 꺼지면 MS Azure로 돌린다.
이런 식으로 가용성을 100%에 가깝게 확보.

## AWS 서비스들

* S3 : 스토리지. 파일 내구도가 99.999% 임.
몇년이 지나도 파일 하나 깨질랑 말랑하는 내구도.
* EC2 : 서버
* ELB (load Balancer) : 서버 url을 DNS서버가 ip로 알려줌. 로드 밸런서는, 대표 ip가 있고 ,트래픽 분산의 역할을 해줌. L4 / L7 밸런서가 있음. 각각 Transport 계층 / Application 계층에서 Load Balancing을 한다고해서 붙은 이름!
WAS도 여러대가 있는데 이 사이에도 internal Load Balancer가 존재한다.
* Auto Scaling : 트래픽에 맞춰서 서버를 늘렸다 줄였다 함!
* RDS : 관계형 DB를 관리한다. DBA의 인력관리를 아끼고 관리를 단순하게 하는 역할! DB에서 primary-standby 를 복사해주고, Read-replica를 만들어주는 등의 역할을 한다.
* DynamoDB: nosql
* IAM : 계정관리 서비스
* CloudWatch : 서버 모니터링 서비스!

# AWS 제어해보기

OS X 에서 AWS CLI를 설치한다.
AWS CLI를 설치하기 위해서는  `python3` 과 그 패키지 매니저인 `pip` 이 필요하고,
OS X 에서 python3 을 설치하는 건 `homebrew` 라는 맥 패키지 매니저를 사용하는게 빠르다.

그러니 순서는 `homebrew설치` - `brew로 python3 설치` - `pip로 awscli설치`가 맞다!


## [Homebrew](https://brew.sh/#install) 설치

터미널을 켜고 상단의 링크를 타고 들어간다.

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
를 붙여넣는다.

## Homebrew로 python3 설치

homebrew 설치가 완료되면 이제 brew를 사용할 수 있다.
터미널에 `brew install python3` 을 입력해서 python3을 설치한다.
pip3은 자동으로 설치된다.

## pip3으로 AWS CLI 설치

`pip install awscli` 혹은 `pip3 install awscli`를 설치한다.

## 키 생성하기

1. AWS에 들어간다.
2. `IAM 서비스` - 사용자 - create credentials
3. access key / secret key를 생성 및 다운로드


## Access key 및 secret key 등록
다음 커맨드를 입력한다.

```
aws configure
AWS Access Key ID [****************2TMA]: AWS Secret Access Key [****************gt+P]: Default region name [ap-northeast-2]: Default output format [json]
```

## 사용해보기

```
aws ec2 describe-instances
aws s3 ls

ec2 describe-instances \
--filters "Name=tag:Name,Values=유저네임*"
ec2 describe-instance --instance-ids i-1234abcd
ec2 start-instances --instance-ids i-1234abcd
ec2 stop-instances --instance-ids i-1234abcd
```


## ec2 시작 / 정지 스크립트

```
#!/bin/bash

instance=i-1234abcd

aws ec2 describe-instances --instance-ids $instance --query Reservations[*].Instances[*].[InstanceId,State.Name,Tags[0].Value,PublicDnsName] --output text

echo '+-------------------+'
echo '| 1. start instance |'
echo '| 2. stop instance  |'
echo '+-------------------+'
printf "choose (1-2): "
read choice

echo $choice
if [ $choice -eq 1 ];then
	echo "start instance $instane"
	aws ec2 start-instances --instance-ids $instance
elif [ $choice -eq 2 ]; then
	echo "stop instance $instance"
	aws ec2 stop-instances --instance-ids $instance --dry-run
else
	echo "bye~"
fi

```
