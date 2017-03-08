# Some other rules

他のルール

### 1. Use Short IF

良い:

```java
public boolean isEmulator(){
    if(someThing){
       return true;  
    }else{
       return false;
    }
}
```

良くない:

```java
public boolean isEmulator(){
   return someThing ? true : false;
}
```
