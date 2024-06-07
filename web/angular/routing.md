# Overview
1. Angular routing cheatsheet


# Add Routes
```ts
export const routes: Routes = [
  {
    children: [],
    component: MyScreen1,
    path: 'foo',
    title: 'Foo Screen'
  },
  {
    children: [],
    component: MyScreen2,
    path: 'bar',
    title: 'Bar Screen'
  },
];
```


# Observing Routing events
```ts

export type NavScreen = 'screen-1' | 'screen-2' | 'screen-3';

@Injectable({
  providedIn: 'root',
})
export class NavStateService {

  private readonly router: Router = inject(Router)
  private readonly _screen$ = new BehaviorSubject<NavScreen>('screen-1')

  const subscription = this.router.events
    .pipe(
        filter(e: any) => e instanceof NavigationEnd),
        map((ne: NavigationEnd) => ne.url),
        distinctUntilChanged()
    )
    .subscribe((url: string) => {
        this._screen$.next(urlToScreen(url));
    });

  ...
}
```


# Deep linking (via sessionState)
- TODO


# Other resources
1. TODO
