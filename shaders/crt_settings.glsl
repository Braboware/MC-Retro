// Making the settings menu sure is a hellscape
// What I would give for a step function i.e. hint_range(0.0, 1.0, 0.05)
// If it exists in optifine pls let me know so I can clean this mess! :)

// Descriptions adapted from https://github.com/AaronWizard/CRTScreenShader


#define crt // Enable CRT effect by EasyMode

#define screen_base_size 240 //[30 60 120 240 480 482 720 1080 1440 2160 4320] The virtual minimum pixel dimension, width or height, of the scene. This should be the minimum of your Width and Height settings if you want 1:1 pixels

#define sharpness_h 0.5 //[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0]
#define sharpness_v 1.0 //[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0]

#define mask_strength 0.3 //[0.0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2  0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3  0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4  0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5  0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6  0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7  0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8  0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9  0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0] How much the original scene's colours will be replaced by the colouring of the RGB cell pattern.
#define mask_dot_width 1 //[1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100] Multiplier for the widths of the RGB cells, based on Mask Size.
#define mask_dot_height 1 //[1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100] Multiplier for the heights of the RGB cells, based on Mask Size.
#define mask_stagger 0 //[0 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100] Shifts the odd row RGB cells by this amount multiplied by Mask Size.
#define mask_size 1 //[1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100] The base width and height in screen pixels of the RGB cells.

#define scanline_strength 1.0 //[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0] How visible the scanlines are.

#define scanline_beam_width_min 1.5 //[0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0]
#define scanline_beam_width_max 1.5 //[0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0]

#define scanline_bright_min 0.35 //[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0]
#define scanline_bright_max 0.65 //[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0]
#define scanline_cutoff 400 //[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 3940 41 42 43 44 45 46 47 48 49 50 51 5253 54 55 56 57 58 59 60 61 62 63 64 6566 67 68 69 70 71 72 73 74 75 76 77 7879 80 81 82 83 84 85 86 87 88 89 90 9192 93 94 95 96 97 98 99 100 101 102 103 104105 106 107 108 109 110 111 112 113 114 115 116 117118 119 120 131 132 133 134 135 136 137 138 139 140 141 142 143144 145 146 147 148 149 150 151 152 153 154 155 156157 158 159 160 161 162 163 164 165 166 167 168 169170 171 172 173 174 175 176 177 178 179 180 181 182196 197 198 199 200 201 202 203 204 205 206 207 208209 210 211 212 213 214 215 216 217 218 219 220 221222 223 224 225 226 227 228 229 230 231 232 233 234235 236 237 238 239 240 241 242 243 244 245 246 247248 249 250 251 252 253 254 255 256 257 258 259 260261 262 263 264 265 266 267 268 269 270 271 272 273274 275 276 277 278 279 280 281 282 283 284 285 286287 288 289 290 291 292 293 294 295 296 297 298 299300 301 302 303 304 305 306 307 308 309 310 311 312313 314 315 316 317 318 319 320 321 322 323 324 325326 327 328 329 330 331 332 333 334 335 336 337 338339 340 341 342 343 344 345 346 347 348 349 350 351352 353 354 355 356 357 358 359 360 361 362 363 364365 366 367 368 369 370 371 372 373 374 375 376 377378 379 380 381 382 383 384 385 386 387 388 389 390391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812 813 814 815 816 817 818 819 820 821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839 840 841 842 843 844 845 846 847 848 849 850 851 852 853 854 855 856 857 858 859 860 861 862 863 864 865 866 867 868 869 870 871 872 873 874 875 876 877 878 879 880 881 882 883 884 885 886 887 888 889 890 891 892 893 894 895 896 897 898 899 900 901 902 903 904 905 906 907 908 909 910 911 912 913 914 915 916 917 918 919 920 921 922 923 924 925 926 927 928 929 930 931 932 933 934 935 936 937 938 939 940 941 942 943 944 945 946 947 948 949 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000] The minimum height the screen must be in order to show the scanlines.

#define gamma_input 2.0 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0] Represents the gamma of the simulated CRT monitor, which was typically between 2 and 5. Darkens the scene the higher this is.
#define gamma_output 1.8 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0] The corrected gamma converted from Gamma Input for display on an LCD monitor. Brightens the scene the higher this is.

#define bright_boost 1.2 //[1.0 1.01 1.02 1.03 1.04 1.05 1.06 1.07 1.08 1.09 1.1 1.11 1.12 1.13 1.14 1.15 1.16 1.17 1.18 1.19 1.2 1.21 1.22 1.23 1.24 1.25 1.26 1.27 1.28 1.29 1.3 1.31 1.32 1.33 1.34 1.35 1.36 1.37 1.38 1.39 1.4 1.41 1.42 1.43 1.44 1.45 1.46 1.47 1.48 1.49 1.5 1.51 1.52 1.53 1.54 1.55 1.56 1.57 1.58 1.59 1.6 1.61 1.62 1.63 1.64 1.65 1.66 1.67 1.68 1.69 1.7 1.71 1.72 1.73 1.74 1.75 1.76 1.77 1.78 1.79 1.8 1.81 1.82 1.83 1.84 1.85 1.86 1.87 1.88 1.89 1.9 1.91 1.92 1.93 1.94 1.95 1.96 1.97 1.98 1.99 2.0] Brightens the scene depending on how high the value is, independent of the gamma settings.

#define dilation 1 //[0 1]