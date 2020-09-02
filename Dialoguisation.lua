script_name = "Dialoguisation"
script_description = "Sélectionnez deux lignes pour en faire une seule sous forme de dialogue"
script_version = "0.4"
script_author = "Afaren"

include('karaskel.lua')

function main(subs, sel, styles)
    
    meta, styles = karaskel.collect_head(subs, false)

    for k, i in ipairs(sel) do
        if k == 1 then
            ligne1 = subs[i]
            num1 = i
            karaskel.preproc_line_size(meta, styles, ligne1)
            ita1 = ligne1.styleref.italic
        else
            ligne2 = subs[i]
            num2 = i
            karaskel.preproc_line_size(meta, styles, ligne2)
            ita2 = ligne2.styleref.italic
        end
    end

    if ligne1.end_time < ligne2.end_time then
        ligne1.end_time = ligne2.end_time
    end
    if ligne1.start_time > ligne2.start_time then
        ligne1.start_time = ligne2.start_time
    end

    l1_ita = nil
    l2_ita = nil

    if ita1 == true or ligne1.text:find("\\i1") ~= nil then
        if ligne1.text:find("\\i1") ~= nil then
            ligne1.text = ligne1.text:gsub("\\i1", "")
            ligne1.text = ligne1.text:gsub("\\i0", "")
            ligne1.text = ligne1.text:gsub("{}", "")
        end
        l1_ita = true
    end
    if ita2 == true or ligne2.text:find("\\i1") ~= nil then
        if ligne2.text:find("\\i1") ~= nil then
            ligne2.text = ligne2.text:gsub("\\i1", "")
            ligne2.text = ligne2.text:gsub("\\i0", "")
            ligne2.text = ligne2.text:gsub("{}", "")
        end
        l2_ita = true
    end
    
    if l1_ita == true and l2_ita == true then
        ligne1.text = "– {\\i1}" .. ligne1.text .. "\\N– " .. ligne2.text
    elseif l1_ita == true and l2_ita == nil then
        ligne1.text = "– {\\i1}" .. ligne1.text .. "{\\i0}\\N– " .. ligne2.text
    elseif l1_ita == nil and l2_ita == true then
        ligne1.text = "– " .. ligne1.text .. "\\N– {\\i1}" .. ligne2.text
    else
        ligne1.text = "– " .. ligne1.text .. "\\N– " .. ligne2.text
    end

    subs[num1] = ligne1
    subs.delete(num2)
    table.remove(sel, 2)
    return sel
end

function validation(subs, sel)
    return #sel==2
end

aegisub.register_macro(script_name, script_description, main, validation)
