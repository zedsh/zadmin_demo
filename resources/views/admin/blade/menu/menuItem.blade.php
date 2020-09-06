<?php
/**
 * @var \App\Admin\Menu\BaseMenuItem $item
 */
?>
<a class="nav-link @if($item->getIsActive()) active @endif" href="{{$item->getLink()}}">{{$item->getTitle()}}</a>

