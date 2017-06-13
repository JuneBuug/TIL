원 출처: https://codelabs.developers.google.com/codelabs/firebase-android/#7



## 텍스트 메시지 보내는 법 적용

﻿이 부분에서는, 앱 유저가 메시지를 보내도록 합니다. 

아래에 있는 코드는 send button의 클릭 이벤트를 주시하다가, 메시지 필드의 내용이 채워진 새로운 `FriendlyMessage `오브젝트를 만듭니다. 그리고 그 메시지를 데이터베이스에 추가합니다. `push()` 메소드는 자동으로 생성된 ID를 추가된 오브젝트 경로에 넣습니다. 이 ID들은 연속적이어서 새로운 메시지들이 리스트 마지막에 추가되도록 합니다. 

`onCreate`  메소드 안에 있는 `mSendButton`  의 `onClick` 메시지를 업데이트해봅시다. `onCreate` 메소드는  `MainActivity` 에 있습니다. 이 코드는 `onCreate` 메소드 맨 아래에 이미 있으므로, 아래의 코드에 맞게 `onClick`  의 내용을 바꿔주세요.

### MainActivity.java 
```
mSendButton = (Button) findViewById(R.id.sendButton);
mSendButton.setOnClickListener(new View.OnClickListener() {
   @Override
   public void onClick(View view) {
       FriendlyMessage friendlyMessage = new 
               FriendlyMessage(mMessageEditText.getText().toString(),
                               mUsername,
                               mPhotoUrl,
                               null /* no image */);
       mFirebaseDatabaseReference.child(MESSAGES_CHILD)
               .push().setValue(friendlyMessage);
       mMessageEditText.setText("");
   }
});

```


## 이미지 메시지 보내는 법 적용
이 부분에서는, 앱 유저가 이미지 메시지를 보내도록합니다. 이미지 메시지를 만드는 과정은 다음과 같습니다. 
* 이미지를 선택한다 
* 이미지 선택을 처리한다
* RTDB에 임시 이미지 메시지를 작성한다
* 선택된 이미지를 업로드 하기 시작한다
* 업로드가 끝나면, 업로드된 이미지의 URL로 이미지 메시지의 URL을 업데이트한다.

### 이미지 선택하기 
다음 코드로 유저가 기기의 로컬 저장소에서 이미지를 선택하도록할 수 있습니다.  
MainActvity - onCreate 메소드안에 있는  `mAddMessageImageView`  의 onClick 메소드를 업데이트 해봅시다. 다음 코드와 현재 작업중인 코드를 맞춰봅시다. 

### MainActivity.java 

```
mAddMessageImageView = (ImageView) findViewById(R.id.addMessageImageView);
mAddMessageImageView.setOnClickListener(new View.OnClickListener() {
   @Override
   public void onClick(View view) {
       Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
       intent.addCategory(Intent.CATEGORY_OPENABLE);
       intent.setType("image/*");
       startActivityForResult(intent, REQUEST_IMAGE);
   }
});

```

### 이미지 선택을 처리하고 임시 메시지 작성하기 

유저가 이미지를 선택하고 나면 MainActivity의 onActivityResult 이 호출될겁니다. 여기에서 유저의 이미지 선택을 처리해줘야합니다. 아래의 코드를 이용해서, onActivityResult 메소드를 MainActivity에 추가합니다. 이 함수에서는 이미지가 업로드 중이라는 것을 나타내기 위해, 임시 이미지 url을 데이터 베이스에 추가하는 작업을 합니다. 


### MainActivity.java 
```
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
   super.onActivityResult(requestCode, resultCode, data);
   Log.d(TAG, "onActivityResult: requestCode=" + requestCode + ", resultCode=" + resultCode);

   if (requestCode == REQUEST_IMAGE) {
       if (resultCode == RESULT_OK) {
           if (data != null) {
               final Uri uri = data.getData();
               Log.d(TAG, "Uri: " + uri.toString());

               FriendlyMessage tempMessage = new FriendlyMessage(null, mUsername, mPhotoUrl,
                       LOADING_IMAGE_URL);
               mFirebaseDatabaseReference.child(MESSAGES_CHILD).push()
                       .setValue(tempMessage, new DatabaseReference.CompletionListener() {
                           @Override
                           public void onComplete(DatabaseError databaseError,
                                                  DatabaseReference databaseReference) {
                               if (databaseError == null) {
                                   String key = databaseReference.getKey();
                                   StorageReference storageReference =
                                           FirebaseStorage.getInstance()
                                           .getReference(mFirebaseUser.getUid())
                                           .child(key)
                                           .child(uri.getLastPathSegment());

                                   putImageInStorage(storageReference, uri, key);
                               } else {
                                   Log.w(TAG, "Unable to write message to database.",
                                           databaseError.toException());
                               }
                           }
                       });
           }
       }
   }
}
```

### 이미지를 업로드하고 메시지를 업데이트하기 

MainActivity 에 `putImageInStorage` 라는 메소드를 추가합시다. 이 메소드는 `onActivityResult` 에서 선택된 이미지의 업로드를 시작하기 위해서 호출됩니다. 업로드가 완료되면,  (업로드된) 이미지를 사용해서 메시지를 업데이트 해줍니다. 

### MainActivity.java 
```
private void putImageInStorage(StorageReference storageReference, Uri uri, final String key) {
   storageReference.putFile(uri).addOnCompleteListener(MainActivity.this,
           new OnCompleteListener<UploadTask.TaskSnapshot>() {
               @Override
               public void onComplete(@NonNull Task<UploadTask.TaskSnapshot> task) {
                   if (task.isSuccessful()) {
                       FriendlyMessage friendlyMessage =
                               new FriendlyMessage(null, mUsername, mPhotoUrl,
                                       task.getResult().getMetadata().getDownloadUrl()
                                               .toString());
                       mFirebaseDatabaseReference.child(MESSAGES_CHILD).child(key)
                               .setValue(friendlyMessage);
                   } else {
                       Log.w(TAG, "Image upload task was not successful.",
                               task.getException());
                   }
               }
           });
}

```

## 메시지 보내기 테스트해보기 
1. Run 버튼을 누릅니다. 
2. 메시지를 입력하고 send 버튼을 누릅니다. 새로운 메시지가 앱 UI와 파이어베이스 콘솔에 보여야합니다. 
3. 이미지를 선택하기 위해서는 + 이미지를 누릅니다. 새로운 메시지가 처음에는 placeholder이미지와, 나중에는 업로드된 이미지로 교체되며 떠야합니다. 새로운 메시지는 데이터베이스에서 오브젝트로, 저장소에서는 blob으로 파이어베이스 콘솔에 보여야합니다.

노트: 이 코드랩에서는 기본 Friendly 메시지들이 10자로 제한되어있습니다.  단계 11에서 어떻게 Remote Config를 사용해서, 심지어 현재 사용하고 있는 클라이언트에 대해서도 이 제한을 변경할 수 있는지  배우게 됩니다. 