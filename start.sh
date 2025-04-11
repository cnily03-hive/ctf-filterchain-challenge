if [ ! -f "/flag" ]; then
    echo "$FLAG" > /flag
    chmod 600 /flag
fi
export FLAG=
apache2-foreground