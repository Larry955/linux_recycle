# linux_recycle
This a simple implementation of recycle in linux using shell.

Here is the instruction:
```bash
cd recycle
chmod +x ./*
./export.sh
```

Here is the usage for **remove.sh**:
```bash
# "remove" one file
remove.sh test.txt
# multi file
remove.sh test.txt test2.txt
# with regex
remove.sh test*
```

After running remove.sh, you will see a new file dubbed as md5 in ${TRASH} (which is ${HOME}/.recycle by default). Take test.txt for example, you will get:
> .recycle/bbfa1f311a5828452b953d1335cbf027

open ${TRASH_MEAT} (which is ${HOME}/.meta by default), you will see the content like this:
> [FILE NAME]:/home/myname/test.txt; [DELETE TIME]:2022-02-27T12:21:17; [MD5]:bbfa1f311a5828452b953d1335cbf027

Then we can recover the test.txt by passing the md5 value to the **recover.sh**:
```bash
recover.sh bbfa1f311a5828452b953d1335cbf027
```

feel free to connect me if you have any trouble in using these scripts
