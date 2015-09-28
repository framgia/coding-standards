# Some other rules

Here some other rules

### 1. Use Short IF

Bad:

```java
public boolean isEmulator(){
    if(someThing){
       return true;  
    }else{
       return false;
    }
}
```

Good:

```java
public boolean isEmulator(){
   return someThing ? true : false;
}
```
