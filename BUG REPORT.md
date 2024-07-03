
# Баг#0
**Описание:** *Короткое описание проблемы, явно указывающие на причину ошибочной ситуации(Можно написать иначе написать по шагам как её получить)*
**Проект:** *CairRobotics*
**Компонент:** *Названия файла где случился баг*
**Номер версии:** *v2.0.0 (В данный момент, смотрите название главной ветки )*   
**Серьезность:** 
*S1 - Critical (Приложение падает выскакивает ошибка)*  
*S2 - Major (Приложение не падает но логика работает не правильно)*   
*S3- Trivial (Желтые ошибки Warning их мы тоже должны фикисить)*
**Ошибка в консоли:**

# Баг#1
**Описание:** *В конструкторе карт вылетает ошибки при нажатие по любому пустому месту (Неправильная обработка Raycast3D)*
**Проект:** *CairRobotics*
**Компонент:** ConstMap.tscn в Camera3D
**Номер версии:** *v2.0.0 *   
**Серьезность:** 
*S1 - Critical (Приложение падает выскакивает ошибка)*  
**Ошибка в консоли:** *Attempt to call function 'intersect_ray' in base 'null instance' on a null instance.*

# Баг#2
**Описание:** *В конструкторе карт вылетает ошибка о том что signal подключен к ноде ControlMove
**Проект:** *CairRobotics*
**Компонент:** Camera3D.gd
**Номер версии:** *v2.0.0 *   
**Серьезность:** 
*S3- Trivial (Желтые ошибки Warning их мы тоже должны фикисить)*
**Ошибка в консоли:** *E 0:00:29:0177   Camera3D.gd:70 @ handle_interaction(): Signal 'cell_pressed' is already connected to given callable 'Camera3D(Camera3D.gd)::ui_view' in that object.
  <Ошибка C++>   Method/function failed. Returning: ERR_INVALID_PARAMETER
  <Исходный код C++>core/object/object.cpp:1358 @ connect()
  <Трассировка стека>Camera3D.gd:70 @ handle_interaction()
                 Camera3D.gd:53 @ _perform_raycast()*


# Баг#3
**Описание:** *Проблема сверсткой на экранах меньше 1980 x1080*
**Проект:** *CairRobotics*
**Компонент:** Проект
**Номер версии:** *v2.0.0  
**Серьезность:** *S2 - Major (Приложение не падает но логика работает не правильно)*   

**Ошибка в консоли:**
![[Pasted image 20240703024937.png]]

# Баг#4
**Описание:** *Нет icon.svg в проекте *
**Проект:** *CairRobotics*
**Компонент:** Проект
**Номер версии:** *v2.0.0 *   
**Серьезность:** 
*S3- Trivial (Желтые ошибки Warning их мы тоже должны фикисить)* 
**Ошибка в консоли:** *Attempt to call function 'intersect_ray' in base 'null instance' on a null instance.*
E 0:00:01:0877   load_image: Error opening file 'res://icon.svg'.
  <Ошибка C++>   Condition "f.is_null()" is true. Returning: err
  <Исходный код C++>core/io/image_loader.cpp:90 @ load_image()
**Статус:** *Исправлен*