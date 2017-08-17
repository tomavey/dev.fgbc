import { Fc2Page } from './app.po';

describe('fc2 App', function() {
  let page: Fc2Page;

  beforeEach(() => {
    page = new Fc2Page();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
