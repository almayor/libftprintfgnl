# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: unite <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/05/10 21:07:48 by unite             #+#    #+#              #
#    Updated: 2020/05/17 04:51:01 by unite            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libftprintfgnl.a

################################################################################

RM = /bin/rm
CP = /bin/cp
CC = /usr/bin/gcc

################################################################################

COMPILE = $(CC) -c
ARCHIVE = /usr/bin/ar rc
INDEX = /usr/bin/ranlib
LINK = $(CC)

CFLAGS = -Wall -Wextra -Werror
CFLAGS_OPTIMISE = -O3 -std=gnu11 -ffast-math -march=native
CFLAGS_DEPEND = -MMD

ifeq ($(DEBUG), 1)
	COMPILE += -g
endif

############################## LINK OBJECT FILES ###############################

$(NAME): get_next_line/get_next_line.o libftprintf
	$(CP) ft_printf/libftprintf.a $(NAME)
	$(ARCHIVE) $(NAME) get_next_line/get_next_line.o
	$(INDEX) $(NAME)

############################ COMPILING LIBFTPRINTF #############################

libftprintf:
	$(MAKE) -C ft_printf PATHFT=../libft DEBUG=$(DEBUG)

################################ COMPILING GNL #################################

get_next_line/get_next_line.o: get_next_line/get_next_line.c
	$(COMPILE) $(CFLAGS) $(CFLAGS_DEPEND) $(CFLAGS_OPTIMISE) $< -o $@ \
		-I libft/ -I get_next_line/

-include get_next_line/get_next_line.d

################################################################################

.PHONY : all clean fclean re libftprintf

all: $(NAME)

clean:
	$(MAKE) -C ft_printf fclean PATHFT=../libft
	$(RM) -f get_next_line/get_next_line.o get_next_line/get_next_line.d

fclean: clean
	$(RM) -f $(NAME)
	$(RM) -f libft.h get_next_line.h ft_printf.h 

re: fclean all

################################################################################
