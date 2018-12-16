grep -oP "(\*/[0-9] |\* ){5}" <<< $(crontab -l)
