
#编译器名称
CC = gcc

#目录
dirInclude := ./include
dirSrc := ./src

#目录设置
vpath %.h $(dirInclude)
vpath %.c %(dirSrc)
vpath %.d %(dirSrc)

#环境变量
CFLAGS = -I$(dirInclude)

#文件集合
listSources := $(wildcard $(dirSrc)/*.c)
listObjects := $(patsubst %.c,%.o, $(notdir $(listSources)))
listDeps != $(patsubst %.c,%.d, $(listSources))
#编译目标名称
targetName := helloworld
$(warning ----------------------)
#依赖关系
.PHONY:all
all : $(targetName)

%.d: %.c
	@set -e; rm -f $@; /
	$(CC) -MM $(CFLAGS) $< > $@.$$$$; /
	c
	rm -f $@.$$$$
	$(warning ----------------------sed 's,/($*/)/.o[ :]*,/1.o $@ : ,g' < $@.$$$$ > $@;)

$(warning ----------------------)
sinclude $(listSources:.c=.d)
$(warning ----------------------)
$(targetName) : $(listObjects)
$(warning ----------------------)
#	$(CC) -o $@ $^

#main.o : common.h
#	$(CC) -c $(CFLAGS) $(dirSrc)/$(patsubst %.o,%.c, $@)

#ljprint.o : ljprint.h
#	$(CC) -c $(CFLAGS) $(dirSrc)/$(patsubst %.o,%.c, $@)


clean :
	-rm $(listObjects) $(targetName)
	$(warning ----------------------)