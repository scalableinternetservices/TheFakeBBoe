module TagsHelper
    def add_if_not_exist(tag)
        if (!Tag.exists?(name:tag))
            Tag.create(name:tag)
        end     
    end
end
