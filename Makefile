# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: unite <marvin@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/05/10 21:07:48 by unite             #+#    #+#              #
#    Updated: 2020/06/05 02:02:54 by unite            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libftprintfgnl.a

################################################################################

COMPILE = gcc -c
ARCHIVE = ar rc
INDEX = ranlib
LINK = gcc

CFLAGS = -Wall -Wextra -Werror
CFLAGS_OPTIMISE = -O3 -std=gnu11 -ffast-math -march=native
CFLAGS_DEPEND = -MMD

ifeq ($(DEBUG), 1)
	COMPILE += -g
endif

############################## LINK OBJECT FILES ###############################

$(NAME): get_next_line/get_next_line.o libftprintf
	cp ft_printf/libftprintf.a $(NAME)
	ar rc $(NAME) get_next_line/get_next_line.o
	randlib $(NAME)

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
	rm -f get_next_line/get_next_line.o get_next_line/get_next_line.d

fclean: clean
	rm -f $(NAME)
	rm -f libft.h get_next_line.h ft_printf.h 

re: fclean all

################################################################################
