module TodosHelper
    def format_date(date_object)
        puts date_object.class
        date_object.to_datetime.strftime("%Y年 %m月 %d日")
    end
end
