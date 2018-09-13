```
cd demo-a
./push.sh
cd ..
cd demo-b
./push.sh
cd ..
cd demo-c
./push.sh
cd ..
```

```
cd demo-b
# edit HelloController.java
./bg-deploy.sh
```

```
while true;do curl -s https://demo-a.cfapps.io -w ' ';date;done
```