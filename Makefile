
#编译器名称
CC = gcc

#目录
dirInclude := include
dirSrc := src

#目录设置
vpath %.h $(dirInclude)
vpath %.c %(dirSrc)
vpath %.d %(dirSrc)

#环境变量
CFLAGS = -I$(dirInclude)

#文件集合
listSources := $(wildcard $(dirSrc)/*.c)
listObjects := $(patsubst %.c,%.o, $(listSources))
listDeps := $(listSources:.c=.d)
#编译目标名称
targetName := helloworld

#依赖关系
.PHONY:all
all : dep $(targetName)
dep : $(listDeps)

$(listDeps) : %.d: %.c
	rm -f $@;\
	$(CC) -MM $(CFLAGS) $< > $@.$$$$;\
	sed 's?$(notdir $*).o:?$(notdir $*).o $(notdir $*).d :?g' < $@.$$$$ > $@;\
	rm -f $@.$$$$
	
	

$(warning --------------------1)
include $(listDeps)
$(warning --------------------2)
$(targetName) : $(listObjects)
	$(CC) -o $@ $^

#main.o : common.h
#	$(CC) -c $(CFLAGS) $(dirSrc)/$(patsubst %.o,%.c, $@)

#ljprint.o : ljprint.h
#	$(CC) -c $(CFLAGS) $(dirSrc)/$(patsubst %.o,%.c, $@)


clean :
	-rm $(listObjects) $(targetName) $(listDeps)

	 