script_name = "Dialoguisation"
script_description = "Sélectionnez deux lignes pour en faire une seule sous forme de dialogue"
script_version = "0.1"
script_author="Afaren"

function main(subs, sel)
    for k, i in ipairs(sel) do
        if k == 1 then
            ligne1 = subs[i]
            num1 = i
        else
            ligne2 = subs[i]
            num2 = i
        end
    end
    ligne1.text = "– " .. ligne1.text .. "\\N– " .. ligne2.text
    ligne1.end_time = ligne2.end_time
    subs[num1] = ligne1
    subs.delete(num2)
end

function validation(subs, sel)
    return #sel==2
end

aegisub.register_macro(script_name,script_description, main, validation)