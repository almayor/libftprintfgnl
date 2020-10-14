# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user <user@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/05/10 21:07:48 by unite             #+#    #+#              #
#    Updated: 2020/10/14 23:28:20 by user             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libftprintfgnl.a

################################################################################

COMPILE = gcc -c
ARCHIVE = ar rc
INDEX = ranlib
LINK = gcc

CFLAGS = -Wall -Wextra -Werror
CFLAGS_DEPEND = -MMD

ifeq ($(DEBUG), 1)
	COMPILE += -g
endif

############################## LINK OBJECT FILES ###############################

$(NAME): ft_printf/libftprintf.a get_next_line/get_next_line.o
	cp ft_printf/libftprintf.a $(NAME)
	$(ARCHIVE) $(NAME) get_next_line/get_next_line.o
	$(INDEX) $(NAME)

################################ COMPILING GNL #################################

get_next_line/get_next_line.o: get_next_line/get_next_line.c
	$(COMPILE) $(CFLAGS) $(CFLAGS_DEPEND) $< -o $@ \
		-I libft/ -I get_next_line/

-include get_next_line/get_next_line.d

################################################################################

.DEFAULT_GOAL = all

.PHONY : all clean fclean re libftprintf

all: libftprintf $(NAME)

clean:
	$(MAKE) -C ft_printf fclean PATHFT=../libft
	rm -f get_next_line/get_next_line.o get_next_line/get_next_line.d

fclean: clean
	rm -f $(NAME)

re: fclean all

libftprintf:
	$(MAKE) -C ft_printf all PATHFT=../libft DEBUG=$(DEBUG)

################################################################################
