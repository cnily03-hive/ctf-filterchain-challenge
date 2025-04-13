if [ ! -f "/flag" ]; then
    echo -n "$FLAG" > /flag
    chmod 600 /flag
fi
export FLAG=
apache2-foreground