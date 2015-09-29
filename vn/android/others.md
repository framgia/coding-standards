# Một số quy tắc khác

Dưới dây là một số quy tắc khác, giúp các bạn tham khảo thêm

### 1. Sử dụng Short IF

Không nên:

```java
public boolean isEmulator(){
    if(someThing){
       return true;  
    }else{
       return false;
    }
}
```

Nên sử dụng:

```java
public boolean isEmulator(){
   return someThing ? true : false;
}
```
